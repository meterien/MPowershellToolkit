# -
# Fonction : installer des applications depuis le disque dur à partir des Variables d'une sequence de taches.
# Description : les fichiers sources sont stockés localement et les repertoires d'installation portent le nom
#               des applications sans espace, editeur ou version sauf exceptions
# -
# Josua Baril-Aumond
# Modif : 2015-08-25
# Dev : 8.50 heures
# 2015-07-15 - 08:20 a 10:48                  (2.50)
# 2015-08-06 - 08:30 a 10:00 et 13:00 a 14:27 (3.00)
# 2015-08-07 - 08:00 a 11:00                  (3.00)
# 2015-08-25 -                                       - Bug: Ajout d'une application avec un nom vide Effet: Installation ActivDriver (1er dossier)
# -
# TODO
# -

# Permet de passer des parametres et d'accepter les parametres de bases ex: -Verbose
[CmdletBinding()]
Param
(        
)

# Definitions des fonctions ----------------------------------------
Function Log-ScriptEvent 
{ 
    #Define and validate parameters 
    [CmdletBinding()] 
    Param( 
        #Path to the log file 
        [parameter(Mandatory=$True)] 
        [String]$NewLog,  
        #The information to log 
        [parameter(Mandatory=$True)] 
        [String]$Value,  
        #The source of the error 
        [parameter(Mandatory=$True)] 
        [String]$Component,  
        #The severity (1 - Information, 2- Warning, 3 - Error) 
        [parameter(Mandatory=$True)] 
        [ValidateRange(1,3)] 
        [Single]$Severity 
    ) 
 
    #Obtain UTC offset 
    $DateTime = New-Object -ComObject WbemScripting.SWbemDateTime  
    $DateTime.SetVarDate($(Get-Date)) 
    $UtcValue = $DateTime.Value 
    $UtcOffset = $UtcValue.Substring(21, $UtcValue.Length - 21) 
 
    #Create the line to be logged 
    $LogLine =  "<![LOG[$Value]LOG]!>" +`
                "<time=`"$(Get-Date -Format HH:mm:ss.fff)$($UtcOffset)`" " +`
                "date=`"$(Get-Date -Format M-d-yyyy)`" " +` 
                "component=`"$Component`" " +` 
                "context=`"$([System.Security.Principal.WindowsIdentity]::GetCurrent().Name)`" " +`
                "type=`"$Severity`" " +`
                "thread=`"$([Threading.Thread]::CurrentThread.ManagedThreadId)`" " +`
                "file=`"`">"
 
    #Write the line to the passed log file 
    $Sw = New-Object -TypeName System.IO.StreamWriter $NewLog, true
    $Sw.WriteLine($LogLine)
    $Sw.Close()
} 

Function Installer-Application
{
    [CmdletBinding()] 
    Param( 
        [parameter(Mandatory=$True)] 
        [ValidateSet("PADT","PS1", "VBScript", "MSI")]
        [String]$Type,
        [parameter(Mandatory=$True)]
        [String]$Journal,
        [parameter(Mandatory=$True)]
        $Fichier,
        [String]$Executable,
        [String]$Parametre
    ) 

    $DebutInstallation = Get-Date
    $CodeErreur = "0"
    Log-ScriptEvent -Value "+ Type: $Type" -Severity 1 -Component "Informations" -NewLog $Journal
    Switch($Type)
    {
        "PADT"
        {
            Log-ScriptEvent -Value "+ Commande : c:\windows\system32\WindowsPowershell\v1.0\powershell.exe -ExecutionPolicy Bypass -Command $Fichier -DeploymentType Install -DeployMode NonInteractive" -Severity 1 -Component "Informations" -NewLog $Journal
            $padt = Start-Process -FilePath "c:\windows\system32\WindowsPowershell\v1.0\powershell.exe" -ArgumentList "-ExecutionPolicy Bypass -Command ""$Fichier"" -DeploymentType Install -DeployMode NonInteractive" -WindowStyle Hidden -PassThru 
            $padt.WaitForExit()
            $CodeErreur = $padt.ExitCode
        }
        "PS1"
        {
            Log-ScriptEvent -Value "c:\windows\system32\WindowsPowershell\v1.0\powershell.exe -ExecutionPolicy Bypass -Command $Fichier" -Severity 1 -Component "Informations" -NewLog $Journal
            $ps1 = Start-Process -FilePath "c:\windows\system32\WindowsPowershell\v1.0\powershell.exe" -ArgumentList "-ExecutionPolicy Bypass -Command ""$Fichier""" -WindowStyle Hidden -PassThru 
            $ps1.WaitForExit()
            $CodeErreur = $ps1.ExitCode       
        }
        "VBScript" 
        {
            Log-ScriptEvent -Value "+ Commande: cmd /C cscript.exe $Fichier" -Severity 1 -Component "Informations" -NewLog $Journal
            $vbscript = Start-Process -FilePath "cmd" -ArgumentList "/C cscript.exe $Fichier" -WindowStyle Hidden -PassThru
            $vbscript.WaitForExit()
            $CodeErreur = $vbscript.ExitCode  
        }
        "MSI"
        {
            Log-ScriptEvent -Value "msiexec /i $Fichier REBOOT=ReallySuppress ALLUSERS=1 /QN" -Severity 1 -Component "Informations" -NewLog $Journal
            $msi = Start-Process -FilePath "msiexec" -ArgumentList "/i $Fichier REBOOT=ReallySuppress ALLUSERS=1 /QN" -WindowStyle Hidden -PassThru
            $msi.WaitForExit()
            $CodeErreur = $msi.ExitCode
        }
    }
    $CodeErreur = $LastExitCode
    Log-ScriptEvent -Value "+ Code de retour : $CodeErreur" -Severity 1 -Component "Informations" -NewLog $Journal
    Log-ScriptEvent -Value "+ Temps d'execution : $(NEW-TIMESPAN –Start $DebutInstallation –End $(Get-Date))" -Severity 1 -Component "Informations" -NewLog $Journal
}

# Definition des Variables pour l'execution ----------------------------------------
$TempsDebutScript = Get-Date
$RepertoireJournalisaton = "$env:windir\Logs\Software"
$NomJournal = "$RepertoireJournalisaton\InstAppsMulticast-$(Get-Date -Format "MM-dd-yyyy").Log"
$DossierScript = Split-Path -Parent $MyInvocation.MyCommand.Path;
$SourcesInstallation = "$env:windir\ccmapps"
[System.Collections.ArrayList]$ApplicationsChoisis = @()

# Importation du module MDT pour lire les Variables de la sequence de taches ----------------------------------------
Import-Module $DossierScript\ZTIUtility.psm1
$VariablesSequenceTaches = Get-ChildItem TSEnv:

# Debut de la journalisation
Log-ScriptEvent -Value "==================" -Severity 1 -Component "Informations" -NewLog $NomJournal
Log-ScriptEvent -Value "Debut de l'execution : $TempsDebutScript" -Severity 1 -Component "Informations" -NewLog $NomJournal
Log-ScriptEvent -Value "Sources d'installation des applications : $SourcesInstallation" -Severity 1 -Component "Informations" -NewLog $NomJournal
Log-ScriptEvent -Value "------------------------------------" -Severity 1 -Component "Informations" -NewLog $NomJournal
Log-ScriptEvent -Value "Liste des applications dynamiques :" -Severity 1 -Component "Informations" -NewLog $NomJournal

# Construire le nom des repertoires d'installation de chaque applications ----------------------------------------
Log-ScriptEvent -Value "Nom de la variable - Valeur - Nom du dossier a trouver" -Severity 1 -Component "Informations" -NewLog $NomJournal
foreach($Variable in $VariablesSequenceTaches)
{
    if(($Variable.Name -match "CoalescedApps..$") -and ($Variable.Value -ne ""))
    {
        # Separer le nom et enlever la version a la fin
        [System.Collections.ArrayList]$NomTemp = ($Variable.Value -split '\s')
        # Si le nom contient au moins un espace, au enleve ce qu'il y a apres le dernier espace
        if($NomTemp.Count -gt 1) { $NomTemp.RemoveAt($NomTemp.Count - 1) }
        # Remettre le nom dans une seule chaine
        $Nom = $($NomTemp -join '')
        $Tmp = $ApplicationsChoisis.Add($Nom)
        Log-ScriptEvent -Value "$($Variable.Name) - $($Variable.Value) - $Nom" -Severity 1 -Component "Informations" -NewLog $NomJournal
    }
}
$NombreApps = $ApplicationsChoisis.Count

# Test d'acces au repertoire qui contient les sources d'installation
Log-ScriptEvent -Value "------------------------------------" -Severity 1 -Component "Informations" -NewLog $NomJournal
if(Test-Path -Path $SourcesInstallation)
{
    $I = 1
    foreach($Application in $ApplicationsChoisis)
    {
        # Installation de l'application à partir de la liste des installateurs
        $SourceApplication = ""
        $SourceApplication = Get-ChildItem -Path $SourcesInstallation -Directory -Filter "*$Application*"
        if($SourceApplication -ne $null -or $Application -like "*WordQ*")
        {
            Log-ScriptEvent -Value "Application $I/$NombreApps : $Application" -Severity 1 -Component "Informations" -NewLog $NomJournal    
            Write-Progress -activity "Installation de l'application" -status "Installation de l'application $I sur $NombreApps : $Application" -PercentComplete (($I / $NombreApps)*100)
            # Cas : WordQ
            if(($Application -like "WordQ*") -and ($Application -notlike "WordQ2.8*"))
            {
                $DebutInstallation = Get-Date
                $CodeErreur = "0"
                Log-ScriptEvent -Value "+ Type: WordQ" -Severity 1 -Component "Informations" -NewLog $NomJournal      
                if($Application -like "*3.1*")
                {
                    $Fichier = "$SourcesInstallation\WordQ3.1\Deploy-Application.ps1"
                    if($Application -like "*Licence*") 
                    { 
                        Log-ScriptEvent -Value "+ Commande : c:\windows\system32\WindowsPowershell\v1.0\powershell.exe -ExecutionPolicy Bypass -Command ""$Fichier"" -DeploymentType Install -DeployMode NonInteractive -Type Licence" -Severity 1 -Component "Informations" -NewLog $NomJournal
                        $proccess = Start-Process -FilePath "c:\windows\system32\WindowsPowershell\v1.0\powershell.exe" -ArgumentList "-ExecutionPolicy Bypass -Command ""$Fichier"" -DeploymentType Install -DeployMode NonInteractive -Type Licence" -WindowStyle Hidden -PassThru -wait 
                    }
                    else
                    {
                        Log-ScriptEvent -Value "+ Commande : c:\windows\system32\WindowsPowershell\v1.0\powershell.exe -ExecutionPolicy Bypass -Command ""$Fichier"" -DeploymentType Install -DeployMode NonInteractive" -Severity 1 -Component "Informations" -NewLog $NomJournal
                        $proccess = Start-Process -FilePath "c:\windows\system32\WindowsPowershell\v1.0\powershell.exe" -ArgumentList "-ExecutionPolicy Bypass -Command ""$Fichier"" -DeploymentType Install -DeployMode NonInteractive" -WindowStyle Hidden -PassThru -wait
                    }
                }       
                if($Application -like "*4*")
                {
                    $Fichier = "$SourcesInstallation\WordQ4\Deploy-Application.ps1"
                    if($Application -like "*Licence*")
                    { 
                        Log-ScriptEvent -Value "+ Commande : c:\windows\system32\WindowsPowershell\v1.0\powershell.exe -ExecutionPolicy Bypass -Command ""$Fichier"" -DeploymentType Install -DeployMode NonInteractive -Type Licence" -Severity 1 -Component "Informations" -NewLog $NomJournal
                        $proccess = Start-Process -FilePath "c:\windows\system32\WindowsPowershell\v1.0\powershell.exe" -ArgumentList "-ExecutionPolicy Bypass -Command ""$Fichier"" -DeploymentType Install -DeployMode NonInteractive -Type Licence" -WindowStyle Hidden -PassThru -wait
                    }
                    else
                    {
                        Log-ScriptEvent -Value "+ Commande : c:\windows\system32\WindowsPowershell\v1.0\powershell.exe -ExecutionPolicy Bypass -Command ""$Fichier"" -DeploymentType Install -DeployMode NonInteractive" -Severity 1 -Component "Informations" -NewLog $NomJournal
                        $proccess = Start-Process -FilePath "c:\windows\system32\WindowsPowershell\v1.0\powershell.exe" -ArgumentList "-ExecutionPolicy Bypass -Command ""$Fichier"" -DeploymentType Install -DeployMode NonInteractive" -WindowStyle Hidden -PassThru -wait
                    }
                }
                $CodeErreur = $($proccess.ExitCode)
                Log-ScriptEvent -Value "+ Code de retour : $CodeErreur" -Severity 1 -Component "Informations" -NewLog $NomJournal
                Log-ScriptEvent -Value "+ Temps d'execution : $(NEW-TIMESPAN –Start $DebutInstallation –End $(Get-Date))" -Severity 1 -Component "Informations" -NewLog $NomJournal
            }
            # Type : Powershell Application Deployment Toolkit
            elseif((Get-ChildItem -Path $SourceApplication.FullName -Filter "Deploy-Application.ps1" -Recurse) -like "Deploy-Application.ps1")
            {
                $Fichier = @(Get-ChildItem -Path $SourceApplication.FullName -Filter "Deploy-Application.ps1" -Recurse)
                Installer-Application -Type PADT -Fichier $Fichier[0].FullName -Journal $NomJournal
            }
            # Type : VBScript
            elseif((Get-ChildItem -Path $SourceApplication.FullName -Filter "*.vbs" -Recurse) -like "*.vbs")
            {
                $Fichier = @(Get-ChildItem -Path $SourceApplication.FullName -Filter "*.vbs" -Recurse)
                Installer-Application -Type VBScript -Journal $NomJournal -Fichier $Fichier[0].FullName
            }
            # Type : Script powershell
            elseif((Get-ChildItem -Path $SourceApplication.FullName -Filter "*.ps1" -Recurse) -like "*.ps1")
            {
                $Fichier = @(Get-ChildItem -Path $SourceApplication.FullName -Filter "*.ps1" -Recurse)
                Installer-Application -Type PS1 -Journal $NomJournal -Fichier $Fichier[0].FullName
            }
            # Type : MSI
            elseif((Get-ChildItem -Path $SourceApplication.FullName -Filter "*.msi" -Recurse) -like "*.msi")
            {
                $Fichier = @(Get-ChildItem -Path $SourceApplication.FullName -Filter "*.msi" -Recurse)
                Installer-Application -Type MSI -Journal $NomJournal -Fichier $Fichier[0].FullName
            }
            # Type : Non geree
            else { Log-ScriptEvent -Value "+ Type: Non gere" -Severity 2 -Component "Informations" -NewLog $NomJournal }
        }
        else { Log-ScriptEvent -Value "Fichiers d'installation introuvables. ($Application)" -Severity 2 -Component "Informations" -NewLog $NomJournal }
        $I ++
        Log-ScriptEvent -Value "------------------------------------" -Severity 1 -Component "Informations" -NewLog $NomJournal
    }
}
else { Log-ScriptEvent -Value "Verifier que le script a acces au repertoire $SourcesInstallation" -Severity 2 -Component "Informations" -NewLog $NomJournal }

# Fin de la journalisation
Log-ScriptEvent -Value "Fin : $(Get-Date) ----" -Severity 1 -Component "Informations" -NewLog $NomJournal
Log-ScriptEvent -Value "Temps d'execution : $(NEW-TIMESPAN –Start $TempsDebutScript –End $(Get-Date)) ----" -Severity 1 -Component "Informations" -NewLog $NomJournal
# -
# Fonction : installer des runtime C++ depuis le disque dur.
# Description : les fichiers sources sont stockés dans des repertoires ex: "Source\2005\vc2005.exe"
# -
# Josua Baril-Aumond
# Modif : 2016-01-07
#
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
    $Sw = New-Object System.IO.StreamWriter $NewLog, true
    $Sw.WriteLine($LogLine)
    $Sw.Close()
} 

Function Installer-Application
{
    [CmdletBinding()] 
    Param( 
        [parameter(Mandatory=$True)] 
        [ValidateSet("2005","2008", "2010", "2012", "2013", "2015")]
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
        "2005"
        {
            Log-ScriptEvent -Value "+ Commande : $fichier /q" -Severity 1 -Component "Informations" -NewLog $Journal
            Start-Process -FilePath "$fichier" -ArgumentList "/q" -WindowStyle Hidden -Wait    
        }
        "2008"
        {
            Log-ScriptEvent -Value "+ Commande : $fichier /q" -Severity 1 -Component "Informations" -NewLog $Journal
            Start-Process -FilePath "$fichier" -ArgumentList "/q" -WindowStyle Hidden -Wait         
        }
        "2010" 
        {
            Log-ScriptEvent -Value "+ Commande : $fichier /q /norestart" -Severity 1 -Component "Informations" -NewLog $Journal
            Start-Process -FilePath "$fichier" -ArgumentList "/q /norestart" -WindowStyle Hidden -Wait    
        }
        "2012"
        {
            Log-ScriptEvent -Value "+ Commande : $fichier /q /norestart" -Severity 1 -Component "Informations" -NewLog $Journal
            Start-Process -FilePath "$fichier" -ArgumentList "/q /norestart" -WindowStyle Hidden -Wait    
        }
        "2013"
        {
            Log-ScriptEvent -Value "+ Commande : $fichier /install /quiet /norestart" -Severity 1 -Component "Informations" -NewLog $Journal
            Start-Process -FilePath "$fichier" -ArgumentList " /install /quiet /norestart" -WindowStyle Hidden -Wait    
        }
        "2015"
        {
            Log-ScriptEvent -Value "+ Commande : $fichier  /install /quiet /norestart" -Severity 1 -Component "Informations" -NewLog $Journal
            Start-Process -FilePath "$fichier" -ArgumentList " /install /quiet /norestart" -WindowStyle Hidden -Wait    
        }
        default
        {
            Log-ScriptEvent -Value "+ Commande : $fichier  /install /quiet /norestart" -Severity 1 -Component "Informations" -NewLog $Journal
            Start-Process -FilePath "$fichier" -ArgumentList " /install /quiet /norestart" -WindowStyle Hidden -Wait    
        }
    }
    $CodeErreur = $LastExitCode
    Log-ScriptEvent -Value "+ Code de retour : $CodeErreur" -Severity 1 -Component "Informations" -NewLog $Journal
    Log-ScriptEvent -Value "+ Temps d'execution : $(NEW-TIMESPAN –Start $DebutInstallation –End $(Get-Date))" -Severity 1 -Component "Informations" -NewLog $Journal
}

# Definition des Variables pour l'execution ----------------------------------------
$TempsDebutScript = Get-Date
$RepertoireJournalisaton = "$env:windir\Logs\Software"
$NomJournal = "$RepertoireJournalisaton\InstCPlusPlusRuntime-$(Get-Date -Format "MM-dd-yyyy").Log"
$DossierScript = Split-Path -Parent $MyInvocation.MyCommand.Path;
$SourcesInstallation = "$DossierScript\Source"

# Debut de la journalisation
Log-ScriptEvent -Value "==================" -Severity 1 -Component "Informations" -NewLog $NomJournal
Log-ScriptEvent -Value "Debut de l'execution : $TempsDebutScript" -Severity 1 -Component "Informations" -NewLog $NomJournal
Log-ScriptEvent -Value "Sources d'installation des applications : $SourcesInstallation" -Severity 1 -Component "Informations" -NewLog $NomJournal

# Test d'acces au repertoire qui contient les sources d'installation
Log-ScriptEvent -Value "------------------------------------" -Severity 1 -Component "Informations" -NewLog $NomJournal
if(Test-Path -Path $SourcesInstallation)
{
    $ListeDossiers = Get-ChildItem $SourcesInstallation
    foreach($Dossier in $ListeDossiers)
    {
        $ListeFichiers = Get-ChildItem "$SourcesInstallation\$($Dossier.Name)"
        foreach($Fichier in $ListeFichiers)
        {
           Log-ScriptEvent -Value "Application : $($Fichier.Name)" -Severity 1 -Component "Informations" -NewLog $NomJournal
           $unType = $($Dossier.Name).Replace('VS', '')
           Installer-Application -Type $unType -Fichier $Fichier.FullName -Journal $NomJournal
        }
    }
}
else { Log-ScriptEvent -Value "Verifier que le script a acces au repertoire $SourcesInstallation" -Severity 2 -Component "Informations" -NewLog $NomJournal }

# Fin de la journalisation
Log-ScriptEvent -Value "Fin : $(Get-Date) ----" -Severity 1 -Component "Informations" -NewLog $NomJournal
Log-ScriptEvent -Value "Temps d'execution : $(NEW-TIMESPAN –Start $TempsDebutScript –End $(Get-Date)) ----" -Severity 1 -Component "Informations" -NewLog $NomJournal
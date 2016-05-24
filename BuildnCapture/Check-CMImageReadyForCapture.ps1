# Permet de passer des parametres et d'accepter les parametres de bases ex: -Verbose
[CmdletBinding()]
param(
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

# Definition des Variables pour l'execution ----------------------------------------
$TempsDebutScript = Get-Date
$RepertoireJournalisaton = "$env:windir\Logs\Software"
$NomJournal = "$RepertoireJournalisaton\CMReadyForCapture.Log"
$DossierScript = Split-Path -Parent $MyInvocation.MyCommand.Path;
$SourcesInstallation = "$env:windir\ccmapps"

# Importation du module MDT pour lire les Variables de la sequence de taches ----------------------------------------
Import-Module $DossierScript\ZTIUtility.psm1
$VariablesSequenceTaches = Get-ChildItem TSEnv:

# Debut de la journalisation
Log-ScriptEvent -Value "==================" -Severity 1 -Component "Informations" -NewLog $NomJournal
Log-ScriptEvent -Value "Debut de l'execution : $TempsDebutScript" -Severity 1 -Component "Informations" -NewLog $NomJournal
Log-ScriptEvent -Value "------------------------------------" -Severity 1 -Component "Informations" -NewLog $NomJournal

# Get-Variable
$doCapture = $true
    # Logs
    Log-ScriptEvent -Value "Journaux" -Severity 1 -Component "Informations" -NewLog $NomJournal
    $postLogsExist = Test-Path "$env:SystemDrive\Windows\Logs\TaskSequenceLogs"
    $postLogs = Get-Item -Path "$env:SystemDrive\Windows\Logs\TaskSequenceLogs"
    if($postLogs) 
    { 
        $postLogsSize = (Get-ChildItem C:\Windows\Logs\TaskSequenceLogs -Recurse | Measure-Object -Property length -sum )
        $postLogsSizeText = "{0:N2}" -f ($postLogsSize.Sum / 1MB) + " MB"
    }
    else
    { 
        $postLogsSize = "0 MB"
        $doCapture = $false
    }
    Log-ScriptEvent -Value "* Dossier TaskSequenceLogs existe : $postLogsExist" -Severity 1 -Component "Informations" -NewLog $NomJournal
    Log-ScriptEvent -Value "* Taille du dossier : $postLogsSizeText" -Severity 1 -Component "Informations" -NewLog $NomJournal
   
    # Applications
    # List of base application
    Log-ScriptEvent -Value "Applications" -Severity 1 -Component "Informations" -NewLog $NomJournal


    # APPS : NetFX 4.6.1
    $netFX4Version = (Get-ItemProperty -Path 'HKLM:\Software\Microsoft\NET Framework Setup\NDP\v4\Client\1033').Version
    if($netFX4Version -lt [version]"4.0") { $doCapture = $false }
    Log-ScriptEvent -Value "* Version du .Net Framework 4 : $netFX4Version" -Severity 1 -Component "Informations" -NewLog $NomJournal

    # APPS : WMF 4
    if($($PSVersionTable.PSVersion) -ge [version]"4.0") { $psversion = $true }
    else {$psversion = $false }
    Log-ScriptEvent -Value "* Version de powershell : $($PSVersionTable.PSVersion)" -Severity 1 -Component "Informations" -NewLog $NomJournal

    # APPS : Microsoft Office
    
    # APPS : VC++
    $listVC = @("Microsoft Visual C++ 2005",
                "Microsoft Visual C++ 2008",
                "Microsoft Visual C++ 2010",
                "Microsoft Visual C++ 2012",
                "Microsoft Visual C++ 2013",
                "Microsoft Visual C++ 2015")
    $nb = 1
    foreach($vcx64 in $listVC)
    {
        $tmpListAppsx86 = Get-ItemProperty HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select DisplayName, Publisher, InstallDate, DisplayVersion | Where-Object { $_.DisplayName -like $("$vcx64*") }
        $tmpvcx86Version = $tmpListAppsx86.DisplayVersion
        Log-ScriptEvent -Value "* Microsoft Visual C++ Redistributable x86 : $tmpvcx86Version" -Severity 1 -Component "Informations" -NewLog $NomJournal
        $tmpListAppsx64 = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select DisplayName, Publisher, InstallDate, DisplayVersion | Where-Object { $_.DisplayName -like $("$vcx64*") }
        $tmpvcx64Version = $tmpListAppsx64.DisplayVersion
        Log-ScriptEvent -Value "* Microsoft Visual C++ Redistributable x64 : $tmpvcx64Version" -Severity 1 -Component "Informations" -NewLog $NomJournal
        $nb ++
    }
    if($nb -lt ($listVC.Count * 2)) { $doCapture = $false }

    # APPS : CMTrace.exe
    $cmtraceExist = Test-Path -Path "$env:SystemDrive\Windows\cmtrace.exe"
    Log-ScriptEvent -Value "* CMTrace.exe existe : $cmtraceExist" -Severity 1 -Component "Informations" -NewLog $NomJournal    # Windows : NetFX 3.5

    # Multicast apps : CCMAPPS size and apps list
    Log-ScriptEvent -Value "Applications multicast" -Severity 1 -Component "Informations" -NewLog $NomJournal

    # APPS : Windows update client version
    Log-ScriptEvent -Value "Updates" -Severity 1 -Component "Informations" -NewLog $NomJournal

    # KB : KB2775511 and KB2728738
    #$kb001 = Get-HotFix -Id KB2775511
    if($kb001) { $kb2775511Exist = $true } else { $kb2775511Exist = $false }
    Log-ScriptEvent -Value "* KB2775511 : $kb2775511Exist" -Severity 1 -Component "Informations" -NewLog $NomJournal
    #$kb002 = Get-HotFix -Id KB2728738
    if($kb002) { $kb2728738Exist = $true } else { $kb2728738Exist = $false }
    Log-ScriptEvent -Value "* KB2728738 : $kb2728738Exist" -Severity 1 -Component "Informations" -NewLog $NomJournal
    # Updates : Get requires updates

    # Others : Get C:\ drive size and freespace
    Log-ScriptEvent -Value "Windows" -Severity 1 -Component "Informations" -NewLog $NomJournal

    # Windows : In a workgroup

    # Windows : Performance mode

# Set-Variable to capture or not

Log-ScriptEvent -Value "Capture" -Severity 1 -Component "Informations" -NewLog $NomJournal
Log-ScriptEvent -Value "* capturer: $doCapture" -Severity 1 -Component "Informations" -NewLog $NomJournal

# Fin de la journalisation
Log-ScriptEvent -Value "Fin : $(Get-Date) ----" -Severity 1 -Component "Informations" -NewLog $NomJournal
Log-ScriptEvent -Value "Temps d'execution : $(NEW-TIMESPAN –Start $TempsDebutScript –End $(Get-Date)) ----" -Severity 1 -Component "Informations" -NewLog $NomJournal
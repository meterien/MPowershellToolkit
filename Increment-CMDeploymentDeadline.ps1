#------
# Originale source
# Benedikt Winder   : http://www.bewi.at/?p=1155
# Russ Slaten       : http://blogs.msdn.com/b/rslaten/archive/2013/11/26/past-due-applications-not-installing-in-sccm-2012.aspx
#------
# Modifié par       : Josua Baril-Aumond
# Date création     : 2015-09-01
# Date modification : 2015-09-03
#------
# Description :       Cet outil va permettre de controler un bug dans ConfigMgr 2012 où les déploiements dans le centre logiciel reste
#                     en état "En retard, va être installé".
#------
# TODO :              Enlever les ordinateurs de la maintenance lorsqu'ils se retrouvent dans Active Directory
#------
[CmdletBinding()]
Param(            
    [parameter(Mandatory=$true)] 
    [String]$pServer,   
    [parameter(Mandatory=$true)]    
    [String]$pSiteCode,
    [String]$pMaxAssignments = 100,
    [String]$logLocation = "$env:SystemRoot\Logs\Software",
    [String]$silent = $false
    )

# Definition des fonctions
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

function GetCMSiteConnection
{
  param ($siteCode)

  $CMModulePath = Join-Path -Path (Split-Path -Path "${Env:SMS_ADMIN_UI_PATH}" -ErrorAction Stop) -ChildPath "ConfigurationManager.psd1"
  Import-Module $CMModulePath -ErrorAction Stop
  $CMProvider = Get-PSDrive -PSProvider CMSite -Name $siteCode -ErrorAction Stop
  CD "$($CMProvider.SiteCode):\"
  return $CMProvider
}

$StartDate = Get-Date
$Date2= Get-Date -Format "MM-dd-yyyy" 
$logName = "$logLocation\CM-IncrementAppsDeadline-$Date2.Log"
[string]$scriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
[String]$SiteServer = $pServer
[String]$SiteCodePlain = $pSiteCode
# Afficher interface si une maintenance manuelle
# if($silent -eq $True) { }
[int]$maxAssignments = $pMaxAssignments
[string]$localdomain = "domain"
[int]$nbAssignmentsNotUpdated = 0

Log-ScriptEvent -Value "======================================" -Severity 1 -Component "Informations" -NewLog $logName
Log-ScriptEvent -Value "Script start : $StartDate" -Severity 1 -Component "Informations" -NewLog $logName
Log-ScriptEvent -Value "--------------------------------------" -Severity 1 -Component "Informations" -NewLog $logName
Log-ScriptEvent -Value "Variables declaration :" -Severity 1 -Component "Variables declaration" -NewLog $logName
Log-ScriptEvent -Value "+ Run from : $scriptDirectory" -Severity 1 -Component "Variables declaration" -NewLog $logName
Log-ScriptEvent -Value "+ Site code : $SiteCodePlain" -Severity 1 -Component "Variables declaration" -NewLog $logName
Log-ScriptEvent -Value "+ Max assignment per query : $maxdevices" -Severity 1 -Component "Variables declaration" -NewLog $logName
Log-ScriptEvent -Value "+ Logs location : $loglocation" -Severity 1 -Component "Variables declaration" -NewLog $logName
Log-ScriptEvent -Value "+ Domain : $localdomain" -Severity 1 -Component "Variables declaration" -NewLog $logName

# - Connexion to ConfigMgr site
Log-ScriptEvent -Value "--------------------------------------" -Severity 1 -Component "Informations" -NewLog $logName
$CM = GetCMSiteConnection -siteCode $SiteCodePlain
Set-CMQueryResultMaximum -Maximum $maxAssignments
Log-ScriptEvent -Value "Connection to ConfigMgr site ($($CM.SiteServer))" -Severity 1 -Component "ConfigMgr connection" -NewLog $logName

# Retrieve all applications deployments from WMI provider
Log-ScriptEvent -Value "+ Gather applications assignments informations" -Severity 1 -Component "ConfigMgr" -NewLog $logName
[System.Collections.ArrayList]$Deployments = Get-WmiObject -ComputerName $SiteServer -Namespace "root\sms\site_$SiteCodePlain" -Query "SELECT AssignmentID, ApplicationName, CollectionName, EnforcementDeadline FROM SMS_ApplicationAssignment ORDER BY AssignmentID"

Log-ScriptEvent -Value "+ Applications assignments found : $($Deployments.Count)" -Severity 1 -Component "ConfigMgr" -NewLog $logName

foreach ($Deployment in $Deployments)
{   
    $deadline = ""
    if($Deployment.EnforcementDeadline -ne $null -and $Deployment.EnforcementDeadline -ne "")
    {
        $deadline = [System.Management.ManagementDateTimeConverter]::ToDateTime($Deployment.EnforcementDeadline)
        $deadlineplus = $deadline.AddMinutes(1)
        if ($deadline -lt (Get-Date).ToUniversalTime())
        {
            Log-ScriptEvent -Value "+ $($Deployment.AssignmentID) CI Deadline Updated : was ($deadline) now ($deadlineplus)" -Severity 1 -Component "ConfigMgr" -NewLog $logName
            Set-CMApplicationDeployment -ApplicationName $Deployment.ApplicationName -CollectionName $Deployment.CollectionName -DeadlineDate $deadlineplus -DeadlineTime $deadlineplus
            $unDeploiement = Get-WmiObject -ComputerName $SiteServer -Namespace "root\sms\site_$SiteCodePlain" -Query "SELECT AssignmentID, ApplicationName, CollectionName, EnforcementDeadline FROM SMS_ApplicationAssignment WHERE AssignmentID = '$($Deployment.AssignmentID)'"
            $deadline = [System.Management.ManagementDateTimeConverter]::ToDateTime($unDeploiement.EnforcementDeadline)
            if($deadline -eq $deadlineplus)
            {
                Log-ScriptEvent -Value "--- Deadline was indeed updated : ($deadline)" -Severity 1 -Component "ConfigMgr" -NewLog $logName
            }
            else
            {
                $nbAssignmentsNotUpdated ++
                Log-ScriptEvent -Value "--- Deadline was not updated : ($deadline)" -Severity 2 -Component "ConfigMgr" -NewLog $logName                
            }
        }
        else
        {
            Log-ScriptEvent -Value "+ $($Deployment.AssignmentID) CI Skipped, deadline time is in the future" -Severity 1 -Component "ConfigMgr" -NewLog $logName
        }
    }
    else
    {
        Log-ScriptEvent -Value "+ $($Deployment.AssignmentID) CI Skipped, deadline time not specified" -Severity 1 -Component "ConfigMgr" -NewLog $logName
    }
}

# Fin de la journalisation 
Set-Location C:
$EndDate = Get-Date
$ScriptRunTime = NEW-TIMESPAN –Start $StartDate –End $EndDate
Log-ScriptEvent -Value "--------------------------------------" -Severity 1 -Component "Informations" -NewLog $logName
Log-ScriptEvent -Value "Assignments that was not correctly updated : $nbAssignmentsNotUpdated" -Severity 1 -Component "Informations" -NewLog $logName
Log-ScriptEvent -Value "Script end : $EndDate" -Severity 1 -Component "Informations" -NewLog $logName
Log-ScriptEvent -Value "Script run time : $ScriptRunTime" -Severity 1 -Component "Informations" -NewLog $logName
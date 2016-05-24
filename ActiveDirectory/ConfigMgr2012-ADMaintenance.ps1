# -----
# Author :            Josua Baril-Aumond
# Creation date :     2015-06-26
# Modification  :     2016-03-10
# Version :           0.1.0
# Description :       FR => Cet outil va permettre de concilier l'inventaire Active Directory et celui de ConfigMgr 2012. Les ordinateurs sont enlevés du groupe
#                           à la prochaine execution du script s'ils se trouvent maintenant sur le contrôleur de domaine. Les ordinateurs qui se conforment avec 
#                           les règles suivante seront déplacé dans un regroupement à cet effet.
#
#                           1. L'ordinateur n'existe pas dans Active Directory mais existe dans ConfigMgr
#
#                     EN => This tool will help maintaint balance between Active Directory and Configuration manager. The computers will be remove from the group
#                           on the next execution of the script if they are now on your domain controller. Computers who are conformant to these rules will be
#                           insert in the selected collection.
#                           Les ordinateurs qui se conforment avec les règles suivante seront déplacé dans un regroupement à cet effet.
#
#                           1. The PC is not in Active Directory but exist in ConfigMgr database
#------

[CmdletBinding()]
Param (
    # Collection ID to perform a consistency check
    [parameter(Mandatory=$True)]
    [String]$idToCheck,         
    # Collection ID to tranfer these pc
    [parameter(Mandatory=$True)]
    [String]$idToTransfert,
    # Maximum devices to query from ConfigMgr
    [Int]$pMaxDevices = 100,    
    [parameter(Mandatory=$True)]
    # Maximum logs count to keep
    [String]$pMaxLogFiles = 30,
    [parameter(Mandatory=$True)]
    # Your domain
    [String]$pDomain,
    # The name of the ConfigMgr server
    [parameter(Mandatory=$True)]
    [String]$pServer,
    # The site code
    [parameter(Mandatory=$True)]
    [String]$pSiteCode,
    # Install folder of the console
    [parameter(Mandatory=$true)]
    [String]$pInstallationFolder
)

# Logging in the CMTRACE.EXE format
Function Log-ScriptEvent { 
    [CmdletBinding()] 
    Param( 
        # Log path
        [parameter(Mandatory=$True)] 
        [String]$NewLog,  
        # Informations 
        [parameter(Mandatory=$True)] 
        [String]$Value,  
        # Source
        [parameter(Mandatory=$True)] 
        [String]$Component,  
        # Level  (1 - Information, 2- Warning, 3 - Error) 
        [parameter(Mandatory=$True)] 
        [ValidateRange(1,3)] 
        [Single]$Severity 
    ) 
 
    # Get UTC time
    $DateTime = New-Object -ComObject WbemScripting.SWbemDateTime  
    $DateTime.SetVarDate($(Get-Date)) 
    $UtcValue = $DateTime.Value 
    $UtcOffset = $UtcValue.Substring(21, $UtcValue.Length - 21) 
 
    # Create an log line
    $LogLine =  "<![LOG[$Value]LOG]!>" +`
                "<time=`"$(Get-Date -Format HH:mm:ss.fff)$($UtcOffset)`" " +`
                "date=`"$(Get-Date -Format M-d-yyyy)`" " +`
                "component=`"$Component`" " +`
                "context=`"$([System.Security.Principal.WindowsIdentity]::GetCurrent().Name)`" " +`
                "type=`"$Severity`" " +`
                "thread=`"$([Threading.Thread]::CurrentThread.ManagedThreadId)`" " +`
                "file=`"`">"
 
    # Write the actual line in the file
    $Sw = New-Object System.IO.StreamWriter $NewLog, true
    $Sw.WriteLine($LogLine)
    $Sw.Close()
} 
# Check the requirement for the script
Function Check-Requirement {
    Log-ScriptEvent -Value "--------------------------------------" -Severity 1 -Component "Requirements" -NewLog $logName
    Log-ScriptEvent -Value "Requirement :" -Severity 1 -Component "Requirements" -NewLog $logName
    $passed = $true
    # ConfigMgr installation folder accessible
    if(-not (Test-Path -Path "$pInstallationFolder\AdminConsole\bin\ConfigurationManager.psd1")) 
    { 
        $passed = $false
        Log-ScriptEvent -Value "+ Console installation folder : Not reachable" -Severity 1 -Component "Requirements" -NewLog $logName
    }
    else
    {
        Log-ScriptEvent -Value "+ Console installation folder : OK" -Severity 1 -Component "Requirements" -NewLog $logName
    }
    # Logging path exist
    if(-not (Test-Path -Path "$env:SystemRoot\Logs\Software")) 
    { 
        $passed = $false
        Log-ScriptEvent -Value "+ Logging path : Not reachable" -Severity 1 -Component "Requirements" -NewLog $logName
    }
    else
    {
        Log-ScriptEvent -Value "+ Logging path : OK" -Severity 1 -Component "Requirements" -NewLog $logName
    }
    # This is a 64 bits process
    if(-not ([Environment]::Is64BitProcess)) 
    {
        $passed = $false
        Log-ScriptEvent -Value "+ 64 bits process : 32 bits" -Severity 1 -Component "Requirements" -NewLog $logName
    }
    else
    {
        Log-ScriptEvent -Value "+ 64 bits process : OK" -Severity 1 -Component "Requirements" -NewLog $logName
    }
    Log-ScriptEvent -Value "Requirements passed : $passed" -Severity 1 -Component "Requirements" -NewLog $logName
    return $passed
}
# Variables initialization
[String]$logLocation = "$env:SystemRoot\Logs\Software"
$StartDate = Get-Date
$Date2= Get-Date -Format "MM-dd-yyyy" 
$logName = "$logLocation\CM-ADMaintenance-$Date2.Log"
[string]$scriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
[String]$SiteServer = $pServer
[String]$SiteCodePlain = $pSiteCode
[string]$sitecode = "$($pSiteCode):"
[String]$idCollectionDevicesToCheck = $idToCheck
[String]$maxLogFiles = $pMaxLogFiles
[String]$idCollectionDevicesTransfer = $idToTransfert
[int]$maxdevices = $pMaxDevices
[string]$localdomain = $pDomain
# Start loggin
Log-ScriptEvent -Value "======================================" -Severity 1 -Component "Informations" -NewLog $logName
Log-ScriptEvent -Value "Script start : $StartDate" -Severity 1 -Component "Informations" -NewLog $logName
Log-ScriptEvent -Value "--------------------------------------" -Severity 1 -Component "Informations" -NewLog $logName
Log-ScriptEvent -Value "ConfigMgr2012-ADMaintenance.ps1" -Severity 1 -Component "Informations" -NewLog $logName
Log-ScriptEvent -Value "--------------------------------------" -Severity 1 -Component "Informations" -NewLog $logName
Log-ScriptEvent -Value "Variables declaration :" -Severity 1 -Component "Variables declaration" -NewLog $logName
Log-ScriptEvent -Value "+ Run from : $scriptDirectory" -Severity 1 -Component "Variables declaration" -NewLog $logName
Log-ScriptEvent -Value "+ ConfigMgr server : $pServer" -Severity 1 -Component "Variables declaration" -NewLog $logName
Log-ScriptEvent -Value "+ Console installation folder : $pInstallationFolder" -Severity 1 -Component "Variables declaration" -NewLog $logName
Log-ScriptEvent -Value "+ Site code : $sitecode" -Severity 1 -Component "Variables declaration" -NewLog $logName
Log-ScriptEvent -Value "+ Perform check on collection ID : $idCollectionDevicesToCheck" -Severity 1 -Component "Variables declaration" -NewLog $logName
Log-ScriptEvent -Value "+ Maintenance collection ID : $idCollectionDevicesTransfer" -Severity 1 -Component "Variables declaration" -NewLog $logName
Log-ScriptEvent -Value "+ Max device per query : $maxdevices" -Severity 1 -Component "Variables declaration" -NewLog $logName
Log-ScriptEvent -Value "+ Logs location : $loglocation" -Severity 1 -Component "Variables declaration" -NewLog $logName
Log-ScriptEvent -Value "+ Domain : $localdomain" -Severity 1 -Component "Variables declaration" -NewLog $logName
# Check if we can reach ConfigMgr, find logging folder and check if this is a 64 bits process
if(Check-Requirement){
    $location = Get-Location
    # Keep the last X logs files
    Log-ScriptEvent -Value "--------------------------------------" -Severity 1 -Component "Informations" -NewLog $logName
    Log-ScriptEvent -Value "Cleanup :" -Severity 1 -Component "Clean logs" -NewLog $logName
    $logFiles = Get-ChildItem -Path $logLocation -Filter "CM-ADMaintenance*.log"
    Log-ScriptEvent -Value "+ Log files count : $($logFiles.Count)/$maxLogFiles" -Severity 1 -Component "Clean logs" -NewLog $logName
    if(($logFiles.Count -gt $maxLogFiles) -and ($maxLogFiles -ne ""))
    {
        [int]$deleteCount = [int]$logFiles.Count - [int]$maxLogFiles
        Log-ScriptEvent -Value "+ File to delete : $deleteCount" -Severity 1 -Component "Clean logs" -NewLog $logName
        for($i = $deleteCount ; $i -gt 0 ; $i --)
        {
            $tempFile = Get-ChildItem -Path $logLocation -Filter "CM-ADMaintenance*.log" | Sort-Object -Property LastWriteTime | Select-Object -First 1
            Log-ScriptEvent -Value "+ Deleting : $($tempFile.FullName)" -Severity 1 -Component "Clean logs" -NewLog $logName
            Remove-Item -Path $tempFile.FullName
        }
    }
    else
    {
        Log-ScriptEvent -Value "+ No file to delete" -Severity 1 -Component "Clean logs" -NewLog $logName
    }
    # Load ConfigMgr powershell
    Log-ScriptEvent -Value "--------------------------------------" -Severity 1 -Component "Informations" -NewLog $logName
    Log-ScriptEvent -Value "Powershell module :" -Severity 1 -Component "Load modules" -NewLog $logName
    if(!(Get-Module -Name "ConfigurationManager"))
    {
        # Load appropriate module
        Log-ScriptEvent -Value "+ Loading ConfigurationManager module" -Severity 1 -Component "Load Modules" -NewLog $logName
        $mess = "Ok"
        $mess = Import-Module -Name "$pInstallationFolder\AdminConsole\bin\ConfigurationManager\ConfigurationManager.psd1" -Verbose
        Log-ScriptEvent -Value "+ Message : $mess" -Severity 1 -Component "Load Modules" -NewLog $logName
    }
    else
    {
        Log-ScriptEvent -Value "+ Configuration module is already loaded" -Severity 1 -Component "Load Modules" -NewLog $logName
    }
    # Connection to the primary site
    Log-ScriptEvent -Value "--------------------------------------" -Severity 1 -Component "Informations" -NewLog $logName
    $mess = Set-Location -Path $sitecode -PassThru
    Set-CMQueryResultMaximum -Maximum $maxdevices
    $computerAddedToMaintenance = @()
    $computerRemovedFromMaintenance = @()
    Log-ScriptEvent -Value "Connection to ConfigMgr site ($sitecodePlain) : $mess" -Severity 1 -Component "ConfigMgr connection" -NewLog $logName
    # Récupérer l'information sur les ordinateurs si le regroupement à vérifier existe
    Log-ScriptEvent -Value "+ Gather computers informations from collection id : $idCollectionDevicesToCheck" -Severity 1 -Component "ConfigMgr connection" -NewLog $logName
    if(Get-CMCollection -Id $idCollectionDevicesToCheck)
    {
        #$Computers = Get-CMDevice -CollectionId $idCollectionDevicesToCheck | Select-Object -Property Name, ResourceID
        [System.Collections.ArrayList]$Computers = Get-WmiObject -ComputerName $SiteServer -Namespace "root\sms\site_$SiteCodePlain" -Query "SELECT Name, ResourceID FROM SMS_FullCollectionMembership WHERE CollectionID='$idCollectionDevicesToCheck' order by name" | Select-Object -Property Name, ResourceID
        if($($Computers.Count) -ne 0)
        {
            Log-ScriptEvent -Value "+ $($Computers.Count) devices found" -Severity 1 -Component "ConfigMgr connection" -NewLog $logName
        }
        else
        {
            Log-ScriptEvent -Value "+ No devices match" -Severity 2 -Component "ConfigMgr connection" -NewLog $logName
        }
        $n = 0
        Log-ScriptEvent -Value "--------------------------------------" -Severity 1 -Component "Informations" -NewLog $logName
        Log-ScriptEvent -Value "Search for match computers in the domain $localdomain : " -Severity 1 -Component "Computers search" -NewLog $logName
        # Remove the unknown computer from the list
        $temp = $Computers | ? { $_.Name -eq "x64 Unknown Computer (x64 Unknown Computer)" }
        $Computers.Remove($temp)
        $temp = $Computers | ? { $_.Name -eq "x86 Unknown Computer (x86 Unknown Computer)" }
        $Computers.Remove($temp)
        # Roll through all computer and find match in Active Directory
        foreach($Computer in $Computers)
        {
            $n ++
            $comp = $Computer.Name
            $searcher = ([adsisearcher]"cn=$comp")
            $rtn = $searcher.FindOne()
            # If not found in Active Directory
            if($rtn.count -eq 0)  
            { 
                Log-ScriptEvent -Value "$n : $comp was not found in Active Directory, performing additionals checks..." -Severity 2 -Component "ActiveDirectory Search" -NewLog $logName
                if(Get-CMDeviceCollectionDirectMembershipRule -CollectionId $idCollectionDevicesTransfer -ResourceId $Computer.ResourceID)
                {
                    Log-ScriptEvent -Value "+ $($Computer.Name) is already in the maintenance collection" -Severity 2 -Component "Cleanup" -NewLog $logName
                }
                else
                {
                    Log-ScriptEvent -Value "+ Adding device $($Computer.Name) to the maintenance collection" -Severity 2 -Component "Cleanup" -NewLog $logName
                    $computerAddedToMaintenance += [pscustomobject]@{
                        "Name" = $Computer.Name
                    }
                    Add-CMDeviceCollectionDirectMembershipRule -CollectionId $idCollectionDevicesTransfer -ResourceId $Computer.ResourceID
                }
            } 
            # Remove computer found in Active Directory from maintenance collection
            else
            {
                $messL = "$n : " + $($rtn.Properties.name) + " was found in Active Directory, it will be kept"
                Log-ScriptEvent -Value $messL -Severity 1 -Component "ActiveDirectory Search" -NewLog $logName
                $pcMaintenance = Get-CMDeviceCollectionDirectMembershipRule -CollectionId $idCollectionDevicesTransfer -ResourceId $($Computer.ResourceID)
                if($pcMaintenance)
                {
                    $messL = $($rtn.Properties.name) + " was found in Active Directory and is in maintenance, we will remove it from maintenance"
                    Log-ScriptEvent -Value "+ $messL" -Severity 2 -Component "ActiveDirectory Search" -NewLog $logName
                    $computerRemovedFromMaintenance += [pscustomobject]@{
                        "Name" = $Computer.Name
                    }
                    Remove-CMDeviceCollectionDirectMembershipRule -CollectionId $idCollectionDevicesTransfer -ResourceId $($Computer.ResourceID) -Force
                }
            }
        }
    }
    else
    {
        Log-ScriptEvent -Value "The collection ID $idCollectionDevicesToCheck is not valid." -Severity 2 -Component "Get ConfigMgr computers" -NewLog $logName
    }
    Set-Location -Path $location
}
# Sommary
Log-ScriptEvent -Value "--------------------------------------" -Severity 1 -Component "Summary" -NewLog $logName
Log-ScriptEvent -Value "Computer added to maintenance :" -Severity 1 -Component "Summary" -NewLog $logName
foreach($computer in $computerAddedToMaintenance)
{
    Log-ScriptEvent -Value "+ $($computer.Name)" -Severity 2 -Component "Summary" -NewLog $logName   
}
Log-ScriptEvent -Value "Computer removed from maintenance :" -Severity 1 -Component "Summary" -NewLog $logName
foreach($computer in $computerRemovedFromMaintenance)
{
    Log-ScriptEvent -Value "+ $($computer.Name)" -Severity 2 -Component "Summary" -NewLog $logName   
}
# End logging
$EndDate = Get-Date
$ScriptRunTime = NEW-TIMESPAN –Start $StartDate –End $EndDate
Log-ScriptEvent -Value "--------------------------------------" -Severity 1 -Component "Informations" -NewLog $logName
Log-ScriptEvent -Value "Script end : $EndDate" -Severity 1 -Component "Informations" -NewLog $logName
Log-ScriptEvent -Value "Script run time : $ScriptRunTime" -Severity 1 -Component "Informations" -NewLog $logName
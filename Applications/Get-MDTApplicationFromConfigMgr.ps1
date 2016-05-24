# Must have ImportExcel module available

param(
    $siteServer = "ConfigMgr01",
    $siteCode = "001",
    $udiCollection = "UDISoftwareCollection",
    $outputFile = ".\"
)

$modulePath = ".\Modules\ImportExcel"
if(Test-Path -Path $modulePath) { Import-Module $modulePath }

$applications = @()
$applications = Get-WmiObject -ComputerName $siteServer -Namespace "root\sms\site_$siteCode" -Query "SELECT ApplicationName FROM SMS_ApplicationAssignment WHERE CollectionName = '$udiCollection' ORDER BY ApplicationName" | Select-Object -Property ApplicationName

#$filteredApplications = 
<#$applications | Where-Object { 
    ($_.ApplicationName -inotlike '*Java*') -and 
    ($_.ApplicationName -inotlike '*ultravnc*') -and
    ($_.ApplicationName -inotlike '*Management*') -and
    ($_.ApplicationName -inotlike '*winsat*') -and
    ($_.ApplicationName -inotlike '*office*') 
}#>

$applications | Export-Excel -Path $outputFile -WorkSheetname "UDISoftware" -Title "Software available in the UDI Wizard" -AutoSize


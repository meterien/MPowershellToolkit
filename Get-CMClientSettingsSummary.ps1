# Export a report of all client settings to a CSV. Based on http://www.verboon.info/2013/05/powershell-script-to-retrieve-sccm-2012-client-settings/
# Author: Stephen Leuthold 
 
import-module($Env:SMS_ADMIN_UI_PATH.Substring(0,$Env:SMS_ADMIN_UI_PATH.Length-5) + '\ConfigurationManager.psd1')
$location = Get-Location
#[string]$cmSiteCode = "{0}:" -f (Get-CMSite).SiteCode
[string]$cmSiteCode = "799:"
CD $cmSiteCode
 
[string]$reportOutput = "c:\personnel\temp\ClientSettings.csv"
[array]$reportAll = @()
# Get the different Client settings Names
$a = Get-CMClientSetting  | select Name
 
foreach ($a in $a ) 
{
	# Get all possible values for the Get-CMClientSetting -Setting parameter
	$xsettings = [Enum]::GetNames( [Microsoft.ConfigurationManagement.Cmdlets.ClientSettings.Commands.SettingType])
	# dump the detailed configuration settings
	foreach ($xsetting in $xsettings ) {
	    $cmClientSettings = Get-CMClientSetting -Setting $xsetting -Name $a.Name 
 
        if($cmClientSettings.count -gt 0) {
            $cmClientSettings.GetEnumerator() | % {
                $cmClientSettingsObj = New-Object PSObject -Property ([ordered]@{
                 "Client Setting" = $a.Name;
                 "Type" = $xsetting;
                 "Key" = $_.Key;
                 "Value" = $_.Value;
                })
 
                $reportAll += $cmClientSettingsObj
            }
        }
    }
 
}
$reportAll | Export-Csv -Path $reportOutput -NoTypeInformation

CD $location
# https://petermassa.com/?p=550

# ID 
# (Readability) = "oknpjjbmpnndlpmnhmekjpocelpnlfdi"

param(
    [String]$appid
)

if(-not (Test-Path -Path HKLM:\Software\Policies\Google\Chrome)) { New-Item -Path HKLM:\Software\Policies\Google -Name Chrome –Force }

if (Test-Path -Path HKLM:\Software\Policies\Google\Chrome\ExtensionInstallForcelist) {
    Get-ChildItem -Path HKLM:\Software\Policies\Google\Chrome\ExtensionInstallForcelist
} else {
    New-Item -Path HKLM:\Software\Policies\Google\Chrome -Name ExtensionInstallForcelist –Force
}
$count = 1
$flag = $false
$va = Get-ChildItem hklm:\software\policies\google\chrome\
$va | foreach-object {
    # Check for existing entry of that extension
    $tempItem = $_ | get-itemproperty
    if ($tempItem -match $appid -and $_.Name -match "ExtensionInstallForcelist") {
        $tempItem
        $flag = $true
    }
    # Check for next available id
    if ($_.Name -match "ExtensionInstallForcelist") {
        [int]$intNum = [convert]::ToInt32($_.ValueCount, 10)
        $count = $count + $intNum
        $count
    }
}
$flag
if ($flag -eq $false) {
    # Install extension
    New-ItemProperty -Path HKLM:\Software\Policies\Google\Chrome\ExtensionInstallForcelist -Name $count -Value "$($appid);https://clients2.google.com/service/update2/crx" –Force
}
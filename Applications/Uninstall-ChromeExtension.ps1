# https://petermassa.com/?p=550

# ID 
# (Readability) = "oknpjjbmpnndlpmnhmekjpocelpnlfdi"

param(
    [String]$appid
)

if (Test-Path -Path HKLM:\Software\Policies\Google\Chrome) {
    # Already exists
} else {
    New-Item -Path HKLM:\Software\Policies\Google -Name Chrome –Force
}
if (Test-Path -Path HKLM:\Software\Policies\Google\Chrome\ExtensionInstallForcelist) {
    Get-ChildItem -Path HKLM:\Software\Policies\Google\Chrome\ExtensionInstallForcelist
} else {
    New-Item -Path HKLM:\Software\Policies\Google\Chrome -Name ExtensionInstallForcelist –Force
}
$count = 1
$appids = @()
$flag = $false
$va = Get-ChildItem hklm:\software\policies\google\chrome\
$va | foreach-object {
    # Check for existing entry of that extension
    if ($_.Name -match "ExtensionInstallForcelist") {
        $_.Property | foreach-object {
            $temp = Get-ItemProperty -Path HKLM:\Software\Policies\Google\Chrome\ExtensionInstallForcelist -name $_
            if ($temp.$_ -match $appid) {
                # Uninstall flag
                $flag = $true
            } else {
                $appids += $temp.$_
            }
        }
    }
}
if ($flag) {
    Remove-Item -Path HKLM:\Software\Policies\Google\Chrome\ExtensionInstallForcelist –Force
    New-Item -Path HKLM:\Software\Policies\Google\Chrome -Name ExtensionInstallForcelist –Force
    $appids | foreach-object {
        # Reinstall valid apps in order to remove id gaps
        New-ItemProperty -Path HKLM:\Software\Policies\Google\Chrome\ExtensionInstallForcelist -Name $count -Value $_ –Force
        $count = $count + 1
    }
}
param(
    [Parameter(Mandatory=$true)]
    [String]$Enable = $true
)

# Get the current location
$currentLocation = Split-Path -Parent $MyInvocation.MyCommand.Path

# Enable preview desktop (0=Enable and 1=Disable)
if($Enable)
{
    New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "DisablePreviewDesktop" -PropertyType DWORD -Value 1 -Force
}
else
{
    New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "DisablePreviewDesktop" -PropertyType DWORD -Value 0 -Force
}
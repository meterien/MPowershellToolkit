param(
    [Parameter(Mandatory=$true)]
    [String]$Enable = $true
)

# Get the current location
$currentLocation = Split-Path -Parent $MyInvocation.MyCommand.Path

# Replace CMD by Powershell when Win+X (0=Powershell and 1=CMD)
$location = Get-Location
& REG LOAD HKLM\DEFAULT C:\Users\Default\NTUSER.DAT
Push-Location 'HKLM:\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
if($Enable)
{
    New-ItemProperty -Path . -Name "DontUsePowerShellOnWinX" -PropertyType DWORD -Value 1 -Force
}
else
{
    New-ItemProperty -Path . -Name "DontUsePowerShellOnWinX" -PropertyType DWORD -Value 0 -Force
}
Set-Location $location
$unloaded = $false
$attempts = 0
while (!$unloaded -and ($attempts -le 5)) {
  [gc]::Collect() # necessary call to be able to unload registry hive
  & REG UNLOAD HKLM\DEFAULT
  $unloaded = $?
  $attempts += 1
}
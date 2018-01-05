
param(
    [Parameter(Mandatory=$true)]
    [String]$startLayout
)

# Get the current location
$currentLocation = Split-Path -Parent $MyInvocation.MyCommand.Path

# Replace command prompt with powershell (No longer used)
#New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "DontUsePowerShellOnWinX" -PropertyType DWORD -Value 0 -Force

# Show system icons on the desktop (0=Show and 1=Hide)
<#
  My Computer   {20D04FE0-3AEA-1069-A2D8-08002B30309D}
  Library       {031E4825-7B94-4dc3-B131-E946B44C8DD5}
  ???????       {208D2C60-3AEA-1069-A2D7-08002B30309D}
  Control Panel {5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}
  My Documents  {59031a47-3f72-44a7-89c5-5595fe6b30ee}
  ???????       {871C5380-42A0-1069-A2EA-08002B30309D}
  ???????       {9343812e-1c37-4a49-a12e-4b2d810d956b}
  ???????       {B4FB3F98-C1EA-428d-A78A-D1F5659CBA93}
  Network       {F02C1A0D-BE21-4350-88B0-7367FC96EF3C}
#>
New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -PropertyType DWORD -Value 0 -Force
New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" -PropertyType DWORD -Value 0 -Force

# Launch the file explorer in This PC view (1=ThisPC and 0=QuickAccess)
New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -PropertyType DWORD -Value 1 -Force

# Disable Location and Sensors (0=Enable and 1=Disable)
#New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableWindowsLocationProvider" -PropertyType DWORD -Value 1 -Force


#New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" -Name "LegacyDefaultPrinterMode" -PropertyType DWORD -Value 1 -Force

# Disable network delivery optimization service
<#
  0 = Off
  1 = On, PCs on my local network
  3 = On, PCs on my local network, and PCs on the Internet
#>
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Name "DODownloadMode" -PropertyType DWORD -Value 0 -Force

# Disable Windows feedback
if(-not (Test-Path "HKLM:\Software\Microsoft\Siuf\Rules")) { New-Item -Path "HKLM:\Software\Microsoft\Siuf\Rules" }
New-ItemProperty -Path "HKLM:\Software\Microsoft\Siuf\Rules" -Name "PeriodInNanoSeconds" -PropertyType DWORD -Value 0 -Force
New-ItemProperty -Path "HKLM:\Software\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -PropertyType DWORD -Value 0 -Force

# Disable Wifi-Sense
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" -Name "AutoConnectAllowedOEM" -PropertyType DWORD -Value 0 -Force

# Disable Microsoft consumer experiences
if(-not (Test-Path -Path"HKLM:\Software\Policies\Microsoft\Windows\CloudContent")) { New-Item -Path "HKLM:\Software\Policies\Microsoft\Windows\CloudContent" -Force }
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -PropertyType DWORD -Value 1 -Force

# Set the default start layout
if(Test-Path $startLayout)
{
    #Copy-Item -Path "$currentLocation\Internet Explorer.lnk" -Destination "$env:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs" -Force
    Import-StartLayout -LayoutPath $startLayout -MountPath $env:SystemDrive
}

# Set cortana search bar mode
<#
    0 = Hidden
    1 = Show Cortana icon
    2 = Show search box
#>
#New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -PropertyType DWORD -Value 2 -Force
$location = Get-Location
& REG LOAD HKLM\DEFAULT C:\Users\Default\NTUSER.DAT
if(-not (Test-Path -Path "HKLM:\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Search")) { New-Item -Path "HKLM:\DEFAULT\Software\Software\Microsoft\Windows\CurrentVersion\Search" -Force }
Push-Location "HKLM:\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Search"
New-ItemProperty -Path . -Name "SearchboxTaskbarMode" -PropertyType DWORD -Value 2 -Force
#if(-not (Test-Path -Path "HKLM:\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People")) { New-Item -Path "HKLM:\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Force }
#Push-Location 'HKLM:\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People'
#New-ItemProperty -Path . -Name "PeopleBand" -PropertyType DWORD -Value 0 -Force
Set-Location $location
$unloaded = $false
$attempts = 0
while (!$unloaded -and ($attempts -le 5)) {
  [gc]::Collect() # necessary call to be able to unload registry hive
  & REG UNLOAD HKLM\DEFAULT
  $unloaded = $?
  $attempts += 1
}

# Disable cortana
if(-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search")) { New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" }
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -PropertyType DWORD -Value 0 -Force

# Set the Telemetry level to security only
<#
  0. This setting maps to the Security level.
  1. This setting maps to the Basic level.
  2. This setting maps to the Enhanced level
  3. This setting maps to the Full level.
#>
New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -PropertyType DWORD -Value 0 -Force

# Remove the lock screen (swipe panel before login)
if(-not (Test-Path -Path "HKLM:\Software\Policies\Microsoft\Windows\Personalization")) { New-Item -Path "HKLM:\Software\Policies\Microsoft\Windows\Personalization" -Force }
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\Personalization" -Name "NoLockScreen" -PropertyType DWORD -Value 1 -Force

# Configure the Windows Store
if(-not (Test-Path -Path "HKLM:\Software\Policies\Microsoft\WindowsStore")) { New-Item -Path "HKLM:\Software\Policies\Microsoft\WindowsStore" -Force }
#New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\WindowsStore" -Name "RequirePrivateStoreOnly" -PropertyType DWORD -Value 1 -Force
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\WindowsStore" -Name "RemoveWindowsStore" -PropertyType DWORD -Value 1 -Force

# Allow third party application installation
New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "AicEnabled" -PropertyType STRING -Value "Anywhere" -Force

# Set the DPI to 100 pourcent
$location = Get-Location
& REG LOAD HKLM\DEFAULT C:\Users\Default\NTUSER.DAT
Push-Location 'HKLM:\DEFAULT\Control Panel\Desktop'
New-ItemProperty -Path . -Name "LogPixels" -PropertyType DWORD -Value 96 -Force
New-ItemProperty -Path . -Name "Win8DpiScaling" -PropertyType DWORD -Value 0 -Force
Set-Location $location
$unloaded = $false
$attempts = 0
while (!$unloaded -and ($attempts -le 5)) {
  [gc]::Collect() # necessary call to be able to unload registry hive
  & REG UNLOAD HKLM\DEFAULT
  $unloaded = $?
  $attempts += 1
}

# Disable the new managed default printer (0=Enable and 1=Disable)
$location = Get-Location
& REG LOAD HKLM\DEFAULT C:\Users\Default\NTUSER.DAT
Push-Location 'HKLM:\DEFAULT\Software\Microsoft\Windows NT\CurrentVersion\Windows'
New-ItemProperty -Path . -Name "LegacyDefaultPrinterMode" -PropertyType DWORD -Value 1 -Force
Set-Location $location
$unloaded = $false
$attempts = 0
while (!$unloaded -and ($attempts -le 5)) {
  [gc]::Collect() # necessary call to be able to unload registry hive
  & REG UNLOAD HKLM\DEFAULT
  $unloaded = $?
  $attempts += 1
}

# Disable people icon
$location = Get-Location
& REG LOAD HKLM\DEFAULT C:\Users\Default\NTUSER.DAT
if(-not (Test-Path -Path "HKLM:\DEFAULT\Software\Policies\Microsoft\Windows\Explorer")) { New-Item -Path "HKLM:\DEFAULT\Software\Policies\Microsoft\Windows\Explorer" -Force }
Push-Location "HKLM:\DEFAULT\Software\Policies\Microsoft\Windows\Explorer"
New-ItemProperty -Path . -Name "HidePeopleBar" -PropertyType DWORD -Value 1 -Force
#if(-not (Test-Path -Path "HKLM:\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People")) { New-Item -Path "HKLM:\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Force }
#Push-Location 'HKLM:\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People'
#New-ItemProperty -Path . -Name "PeopleBand" -PropertyType DWORD -Value 0 -Force
Set-Location $location
$unloaded = $false
$attempts = 0
while (!$unloaded -and ($attempts -le 5)) {
  [gc]::Collect() # necessary call to be able to unload registry hive
  & REG UNLOAD HKLM\DEFAULT
  $unloaded = $?
  $attempts += 1
}
$regKey = "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_DISABLE_IE11_SECURITY_EOL_NOTIFICATION"
$regKey32bits = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_DISABLE_IE11_SECURITY_EOL_NOTIFICATION"
$name = "iexplore.exe"
$val = "00000001"
$type = "DWORD"

if(-not (Test-Path $regKey)) { New-Item -Path $regKey -Force }
if(-not (Test-Path $regKey32bits)) { New-Item -Path $regKey32bits -Force }
New-ItemProperty $regKey -Name $name -Value $val -PropertyType $type -Force
New-ItemProperty $regKey32bits -Name $name -Value $val -PropertyType $type -Force

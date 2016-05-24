$regKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$name = "HideFastUserSwitching"
$val = "0"
$type = "DWORD"

New-ItemProperty $regKey -Name $name -Value $val -PropertyType $type -Force

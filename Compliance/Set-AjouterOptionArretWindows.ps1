$regKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$name = "NoClose"
$val = "0"
$type = "DWORD"

New-ItemProperty $regKey -Name $name -Value $val -PropertyType $type -Force

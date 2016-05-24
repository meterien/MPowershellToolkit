$regKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$name = "HideFastUserSwitching"

$regValue = Get-ItemProperty $regKey $name -ErrorAction SilentlyContinue

if(($? -and ($regValue -ne $null)))
{
$regValue.$name
}
else
{
# SCCM doesn't like when we return NULL values...
-1
}
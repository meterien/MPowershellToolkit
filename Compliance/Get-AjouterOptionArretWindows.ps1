$regKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$name = "NoClose"

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
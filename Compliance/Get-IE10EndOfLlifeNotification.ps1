$regKey = "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_DISABLE_IE11_SECURITY_EOL_NOTIFICATION"
$name = "iexplore.exe"

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
# This function tests if a registry value exists, returning True if the value exists
function Test-RegistryValue ([string] $key, [string] $name) 
{ 
    Get-ItemProperty -Path "$key" -Name "$name" -ErrorAction SilentlyContinue | Out-Null; 
    return $?; 
} 

$NICRegPathRoot = "HKLM:SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002bE10318}\"
$nics = Get-WmiObject Win32_NetworkAdapter -filter "AdapterTypeID = '0' AND PhysicalAdapter = 'true'"
$nombreCarteIntel = 0
$erreurs = 0

foreach ($nic in $nics)
{
    $nicDeviceID = $nic.Caption.Substring(5,4)
    $nicKey = $NICRegPathRoot + $nicDeviceID
    If (($nic.Name -like "Intel*") -and (Test-RegistryValue $nicKey "EnablePME") -and ($nic.Name -notlike "*Wireless*"))
    {
        $nombreCarteIntel ++
        if($(Get-ItemProperty -Path $nicKey -Name 'EnablePME').EnablePME -eq 0) { $erreurs ++ }
    }
}

if(($nombreCarteIntel -eq 0) -or ($erreurs -eq 0))
{
    return 'Compliant'
}
else
{
    return 'NonCompliant'
}
# This function tests if a registry value exists, returning True if the value exists
function Test-RegistryValue ([string] $key, [string] $name) 
{ 
    Get-ItemProperty -Path "$key" -Name "$name" -ErrorAction SilentlyContinue | Out-Null; 
    return $?; 
} 

# List of Intel NICs that we want to check
$IntelCardsOfInterest = "Intel"

# Registry path where NIC driver settings are stored
$NICRegPathRoot = "HKLM:SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002bE10318}\"

# Get all physical ethernet adaptors
# This will also get wireless adaptors, but the whitelist above will exlude those
$nics = Get-WmiObject Win32_NetworkAdapter -filter "AdapterTypeID = '0' AND PhysicalAdapter = 'true'"

foreach ($nic in $nics)
{
    # NIC index value we use this to find the right registry
    # key for the NIC we are working with
    $nicDeviceID = $nic.Caption.Substring(5,4)

    # Registry path to the for the specific NIC we are looking at
    $nicKey = $NICRegPathRoot + $nicDeviceID

    # Test if the NIC is in our whitelist above and if the "EnablePME value exists
    # Some cards are in our whitelist but don't have this setting on all models where 
    # the particualr NIC installed. We only want to change this value if it exists
    If (($nic.Name -like "Intel*") -and (Test-RegistryValue $nicKey "EnablePME") -and ($nic.Name -notlike "*Wireless*"))
    {
        Set-ItemProperty -Path $nicKey -Name "EnablePME" -Value 1
    }
}
# Détection
$QuicktimeInstances = @(Get-WmiObject -Namespace root/cimv2/sms -Class sms_installedsoftware -Filter "ProductName LIKE '%QuickTime%'")
if($QuicktimeInstances.Count -gt 0) {
    return 'NonCompliant'
}
else {
    return 'Compliant'
}

# Correction
$QuicktimeInstances = @(Get-WmiObject -Namespace root/cimv2/sms -Class sms_installedsoftware -Filter "ProductName LIKE '%QuickTime%'")
foreach($Instance in $QuicktimeInstances) {
    Write-Host "$($Instance.ProductName) : $($Instance.ProductVersion)"
    $null = Start-Process -FilePath msiexec -ArgumentList "/X $($Instance.SoftwareCode) REBOOT=ReallySuppress /QN" -Wait -Verb RunAs -WindowStyle Hidden
}
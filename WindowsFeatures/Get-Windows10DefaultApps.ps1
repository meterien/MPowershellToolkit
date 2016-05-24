param(
    [Parameter(Mandatory=$true)]
    [String]$path
)

$Appx = Get-AppxPackage | select name
$appx | Out-File -FilePath $path
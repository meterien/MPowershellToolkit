param(
    [Parameter(Mandatory=$true)]
    [String]$path
)

Start-Process -FilePath "Dism.exe" -ArgumentList "/online /Export-DefaultAppAssociations:$path\DefaultApps.xml" -Wait
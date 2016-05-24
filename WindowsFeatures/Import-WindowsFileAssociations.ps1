param(
    [Parameter(Mandatory=$true)]
    [String]$file
)

Start-Process -FilePath "Dism.exe" -ArgumentList "/online /Import-DefaultAppAssociations:$file" -Wait
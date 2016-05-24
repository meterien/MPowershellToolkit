# Script installation : Extraction de pilote HP
# Description : Prend en charge seulement les executables
param(
    [String]$source,
    [String]$destination,
    [String]$model = "ExtractContent"
)

$CurrentLocation = Split-Path -Parent $MyInvocation.MyCommand.Path;

# Create sub-folder to extract content
if((Test-Path "$destination\$model") -eq $false) { New-Item -Path "$destination\$model" -ItemType Folder }

# Get all matched EXE sub-items
Get-ChildItem $source -Recurse | ForEach-Object {
    If($_.Extension.Contains('.exe'))
    { 
        Start-Process -FilePath $_.FullName -ArgumentList "/f $destination\$model\$_ /s /e" -Wait -Verb RunAs
    }
}

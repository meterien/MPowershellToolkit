 <#

    .SYNOPSIS
    
    Download SCEP definitions from Microsoft website and save them in a folder.

    .PARAMETER destinationFolder

    This folder must contain 2 extras folder named x86 and x64 or they will be created.

    a single computer name or an array of computer names. You mayalso provide IP addresses.
    
    .EXAMPLE
    
    .\Get-SCEPDefinitions -destinationFolder "\\svr\partage$\SCEP\Definitions"

#>
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [ValidateScript({Test-Path $_})]
    [String]$destinationFolder
)

if(-not (Test-Path "$destinationFolder\x86")) { New-Item -Path "$destinationFolder\x86" -ItemType 'Directory' -Force }
if(-not (Test-Path "$destinationFolder\x64")) { New-Item -Path "$destinationFolder\x64" -ItemType 'Directory' -Force }

$hash = @{
    "x86\mpam-fe.exe" = "http://go.microsoft.com/fwlink/?LinkID=121721&clcid=0x409&arch=x86"
    "x86\mpam-d.exe" = "http://go.microsoft.com/fwlink/?LinkId=211053"
    "x86\nis_full.exe" = "http://go.microsoft.com/fwlink/?LinkID=187316&arch=x86&nri=true"
    "x64\mpam-fe.exe" = "http://go.microsoft.com/fwlink/?LinkID=121721&clcid=0x409&arch=x64"
    "x64\mpam-d.exe" = "http://go.microsoft.com/fwlink/?LinkId=211054"
    "x64\nis_full.exe" = "http://go.microsoft.com/fwlink/?LinkID=187316&arch=x64&nri=true"
}

foreach($fichier in $hash.GetEnumerator())
{
    Invoke-WebRequest -Uri $fichier.Value -OutFile "$destinationFolder\$($fichier.Name)"
}
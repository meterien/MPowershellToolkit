# Thanks to 

# http://codebroth.com/extracting-iso-images-with-powershell/ => Jaume Sancho

param(
    [string]$isoPath = "C:\Personnel\my.iso", 
    [string]$destination = "C:\Personnel\Extracted", 
    [string]$overwrite = $false)

# Get current location
$location = Get-Location

# Extract the content
#$folder =[System.IO.Path]::GetFileNameWithoutExtension($isoPath)
$mount_params = @{ImagePath = $isoPath; PassThru = $true; ErrorAction = "Ignore"}
$mount = Mount-DiskImage @mount_params

if($mount) 
{
    $volume = Get-DiskImage -ImagePath $mount.ImagePath | Get-Volume
    $source = $volume.DriveLetter + ":\*"
    $destination = mkdir $destination
         
    Write-Host "Extracting '$isoPath' to '$destination'..."
    $params = @{Path = $source; Destination = $destination; Recurse = $true;}
    cp @params
    $hide = Dismount-DiskImage @mount_params
    Write-Host "Copy complete"
}
else 
{
    Write-Host "ERROR: Could not mount " $isoPath " check if file is already in use"
}

cd $location
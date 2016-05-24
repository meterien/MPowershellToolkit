# Must have the script "Extract-ISOContent.ps1" in the current directory
# Must have the ConfigMgr console installed locally
# Must have ADK 8.1 installed locally
# Must have powershell v5

Param(
    [String]$p_server = "myserver",
    [String]$p_siteCode = "001",
    [String]$p_imageId = "SMS000088",
    [String]$p_password,
    [String]$p_folder
)

# Import required module (must have admin console)
Import-Module ($Env:SMS_ADMIN_UI_PATH.Substring(0,$Env:SMS_ADMIN_UI_PATH.Length-5) + '\ConfigurationManager.psd1')
Import-Module BitsTransfer  

# Variables
[string]$scriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

# Connect to Config site
$location = Get-Location
cd "$($p_siteCode):"

# Create boot media
$passwordS = ConvertTo-SecureString $p_password -AsPlainText -Force
if(Test-Path $p_folder)
{
    New-CMTaskSequenceMedia -BootableMedia -MediaInputType CdDvd -ProtectPassword $true -Password $passwordS -BootImageId $p_imageId -DistributionPoint $p_server -ManagementPoint $p_server -MediaMode Dynamic -MediaPath "$p_folder\$p_imageId.iso" -MediaSize SizeUnlimited -EnableUnknownSupport $true -CreateMediaSelfCertificate $true -AllowUnattendedDeployment $false
}
else
{
    Write-Host "Veuillez indiquer un dossier de destination valide. ($p_folder)"
    cd $location
    Exit
}

# Return to system drive
cd $location

# Extract the content of the ISO
cd $p_folder
& "$scriptDirectory\Extract-ISOContent.ps1" -isoPath "$p_folder\$p_imageId.iso" -destination "$p_folder\$p_imageId"

# Download the last version of Wimboot and extract it
$url = "http://git.ipxe.org/releases/wimboot/wimboot-latest.zip"
Start-BitsTransfer -Source $url -Destination "$p_folder\wimboot.zip"
Expand-Archive -Path "$p_folder\wimboot.zip" -DestinationPath "$p_folder\wimbootSources\" -Force
$wimbootFolder = Get-ChildItem -Path "$p_folder\wimbootSources"

# Modify the boot image
$mountFolder = "$p_folder\Work\Mount"
$DismExe = "${env:ProgramFiles(x86)}\Windows Kits\8.1\Assessment and Deployment Kit\Deployment Tools\amd64\DISM\dism.exe"
$WimFile = "$p_folder\$p_imageId\sources\boot.wim"
Set-ItemProperty $WimFile -name IsReadOnly -value $false

Write-Host "Début du montage de l'image dans le répertoire : $mountFolder"
$dismProcMount = Start-Process -FilePath $DismExe -ArgumentList "/Mount-Image /ImageFile:$WimFile /index:1 /MountDir:$mountFolder" -PassThru
While($dismProcMount.HasExited -eq $false)
{
    sleep -Seconds 5
    Write-Host "Attente de la fin du processus..."
}

Write-Host "Montage terminé avec le code : $($dismProcMount.ExitCode)"

if($dismProcMount.ExitCode -eq 0)
{
    Write-Host "Copie des fichiers sms dans l'image..."
    Copy-Item -Path "$p_folder\$p_imageId\sms" -Destination "$mountFolder" -Recurse -Force
    Copy-Item -Path "$p_folder\winpeshl.ini" -Destination "$mountFolder\Windows\System32" -Force
    Copy-Item -Path "$p_folder\bootstrap.vbs" -Destination "$mountFolder\sms\bin\x64" -Force
    Copy-Item -Path "$p_folder\cmtrace.exe" -Destination "$mountFolder\Windows\System32" -Force
    Write-Host "Début de l'enregistrement de l'image..."
    $dismProcCommit = Start-Process -FilePath $DismExe -ArgumentList "/Unmount-Image /MountDir:$mountFolder /commit" -PassThru
    While($dismProcCommit.HasExited -eq $false)
    {
        sleep -Seconds 5
        Write-Host "Attente de la fin du processus..."
    }
    Write-Host "Démontage terminé avec le code : $($dismProcCommit.ExitCode)"
}

# Copy needed files on the final folder
Copy-Item -Path "$p_folder\sccm.ipxe" -Destination "$p_folder\Work\Final" -Force
Copy-Item -Path "$p_folder\wimbootSources\$wimbootFolder\wimboot" -Destination "$p_folder\Work\Final" -Force
Copy-Item -Path "$p_folder\$p_imageId\bootmgr" -Destination "$p_folder\Work\Final" -Force
Copy-Item -Path "$p_folder\$p_imageId\boot\bcd" -Destination "$p_folder\Work\Final" -Force
Copy-Item -Path "$p_folder\$p_imageId\boot\boot.sdi" -Destination "$p_folder\Work\Final" -Force
Copy-Item -Path "$p_folder\$p_imageId\sources\boot.wim" -Destination "$p_folder\Work\Final" -Force

# Clean the directory
if(Test-Path $p_folder)
{
    #Rename-Item -Path $p_folder -NewName "$p_folder.$(Get-Date)" -Force
}

# Return to the invocation folder
cd $location
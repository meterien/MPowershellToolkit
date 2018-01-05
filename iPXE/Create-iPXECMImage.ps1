# Must have the script "Extract-ISOContent.ps1" in the current directory
# Must have the ConfigMgr console installed locally
# Must have ADK 8.1 installed locally
# Must have powershell v5

Param(
    [String]$ServerName,
    [String]$SiteCode,
    [String]$BootImageId,
    [String]$MediaPassword,
    [String]$WorkFolder
)

# Import required module (must have admin console)
Import-Module ($Env:SMS_ADMIN_UI_PATH.Substring(0,$Env:SMS_ADMIN_UI_PATH.Length-5) + '\ConfigurationManager.psd1')
Import-Module BitsTransfer  

# Variables
[string]$scriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
# ADK 8.1 
$ADK81 = "${env:ProgramFiles(x86)}\Windows Kits\8.1\Assessment and Deployment Kit\Deployment Tools\amd64\DISM"
# ADK 10
$ADK10 = "${env:ProgramFiles(x86)}\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\DISM"

# Connect to Config site
$location = Get-Location
cd "$($SiteCode):"

# Create boot media
$passwordS = ConvertTo-SecureString $MediaPassword -AsPlainText -Force
if(Test-Path $WorkFolder)
{
    #New-CMTaskSequenceMedia -BootableMedia -MediaInputType CdDvd -ProtectPassword $true -Password $passwordS -BootImageId $BootImageId -DistributionPoint $ServerName -ManagementPoint $ServerName -MediaMode Dynamic -MediaPath "$WorkFolder\$BootImageId.iso" -MediaSize SizeUnlimited -EnableUnknownSupport $true -CreateMediaSelfCertificate $true -AllowUnattendedDeployment $false
    $BootImage = Get-CMBootImage -Id $BootImageId
    $ManagementPoint = Get-CMManagementPoint -SiteCode 799
    $DistributionPoint = Get-CMDistributionPoint -SiteCode 799
    New-CMBootableMedia -AllowUnknownMachine -BootImage $BootImage -DistributionPoint $DistributionPoint -MediaPassword $passwordS -MediaType CdDvd -ManagementPoint $ManagementPoint -MediaMode Dynamic -Path "$WorkFolder\$BootImageId.iso" -AllowUnattended
}
else
{
    Write-Host "Veuillez indiquer un dossier de destination valide. ($WorkFolder)"
    cd $location
    Exit
}

# Return to system drive
cd $location

# Extract the content of the ISO
#cd $WorkFolder
& ".\Extract-ISOContent.ps1" -isoPath "$WorkFolder\$BootImageId.iso" -destination "$WorkFolder\$BootImageId"

# Download the last version of Wimboot and extract it
$url = "http://git.ipxe.org/releases/wimboot/wimboot-latest.zip"
Start-BitsTransfer -Source $url -Destination "$WorkFolder\wimboot.zip"
Expand-Archive -Path "$WorkFolder\wimboot.zip" -DestinationPath "$WorkFolder\wimbootSources\" -Force
$wimbootFolder = Get-ChildItem -Path "$WorkFolder\wimbootSources"

# Modify the boot image
$mountFolder = "$WorkFolder\Work\Mount"
$DismExe = "$ADK10\dism.exe"
$WimFile = "$WorkFolder\$BootImageId\sources\boot.wim"
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
    Copy-Item -Path "$WorkFolder\$BootImageId\sms" -Destination "$mountFolder" -Recurse -Force
    Copy-Item -Path "$WorkFolder\winpeshl.ini" -Destination "$mountFolder\Windows\System32" -Force
    Copy-Item -Path "$WorkFolder\bootstrap.vbs" -Destination "$mountFolder\sms\bin\x64" -Force
    Copy-Item -Path "$WorkFolder\cmtrace.exe" -Destination "$mountFolder\Windows\System32" -Force
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
Copy-Item -Path "$WorkFolder\sccm.ipxe" -Destination "$WorkFolder\Work\Final" -Force
Copy-Item -Path "$WorkFolder\wimbootSources\$wimbootFolder\wimboot" -Destination "$WorkFolder\Work\Final" -Force
Copy-Item -Path "$WorkFolder\$BootImageId\bootmgr" -Destination "$WorkFolder\Work\Final" -Force
Copy-Item -Path "$WorkFolder\$BootImageId\boot\bcd" -Destination "$WorkFolder\Work\Final" -Force
Copy-Item -Path "$WorkFolder\$BootImageId\boot\boot.sdi" -Destination "$WorkFolder\Work\Final" -Force
Copy-Item -Path "$WorkFolder\$BootImageId\sources\boot.wim" -Destination "$WorkFolder\Work\Final" -Force

# Clean the directory
if(Test-Path $WorkFolder)
{
    #Rename-Item -Path $WorkFolder -NewName "$WorkFolder.$(Get-Date)" -Force
}

# Return to the invocation folder
cd $location
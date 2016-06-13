param(
    [parameter(Mandatory=$True)]
    [String]$wimFile,
    [parameter(Mandatory=$True)]
    $mountPoint,
    $dismExe = "${env:ProgramFiles(x86)}\Windows Kits\8.1\Assessment and Deployment Kit\Deployment Tools\amd64\DISM\dism.exe",
    $ccmappsFolder = "C:\Windows\ccmapps",
    $appsToCopy = @()
)

function prereq
{
    $i = 0
    if(-not (Test-Path $mountPoint)) { $i ++ }
    if(-not (Test-Path $dismExe)) { $i ++ }
    if(-not (Test-Path $wimFile)) { $i ++ }
    if($i -eq 0) { return $true }
    else { return $false }
}

if(prereq -eq $true) {
    # Mount wim file with DISM
    Write-Host "Mounting wim file in : $mountPoint"
    $dismProcMount = Start-Process -FilePath $dismExe -ArgumentList "/Mount-Image /ImageFile:$wimFile /index:1 /MountDir:$mountPoint" -PassThru
    While($dismProcMount.HasExited -eq $false)
    {
        sleep -Seconds 15
        Write-Host "Wait for process to end..."
    }
    Write-Host "Mounting ended with error code $($dismProcMount.ExitCode)"
    # Copy the applications sources
    if($appsToCopy)
    {
        foreach($app in $appsToCopy)
        {
            Write-Host "Copy of folder $ccmappsFolder\$app in $mountPoint\Windows\ccmapps"
            If(Test-Path "$mountPoint\Windows\ccmapps\$app") { Remove-Item "$mountPoint\Windows\ccmapps\$app" -Recurse -Force }
            Copy-Item -Path "$ccmappsFolder\$app" -Destination "$mountPoint\Windows\ccmapps" -Recurse
        }
    }
    # Unmount the wim file
    if($dismProcMount.ExitCode -eq 0)
    {
        Write-Host "Unmount and commit image change..."
        $dismProcCommit = Start-Process -FilePath $dismExe -ArgumentList "/Unmount-Image /MountDir:$mountPoint /commit" -PassThru
        While($dismProcCommit.HasExited -eq $false)
        {
            sleep -Seconds 15
            Write-Host "Wait for process to end..."
        }
        Write-Host "Unmount ended with error code $($dismProcCommit.ExitCode)"
    }
}
else {
    Write-Host "Prereq not meet"
}

#$dismProcExtract = Start-Process -FilePath $dismExe -ArgumentList "/Export-Image /SourceImageFile:$wimFile /SourceIndex:1 /Compress:max /DestinationImageFile:Test.wim /DestinationName:Windows22" -PassThru

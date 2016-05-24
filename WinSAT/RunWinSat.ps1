[CmdletBinding()]    
Param
(        
    [Parameter(Mandatory=$false,
                ValueFromPipelineByPropertyName=$true,
                Position=0)]
    [String]$Version = ''
)

$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path;
Start-Process -FilePath "$scriptDirectory\ServiceUIx86.exe" -ArgumentList "-process:explorer.exe -nowait c:\windows\sysnative\WindowsPowershell\v1.0\powershell.exe -ExecutionPolicy Bypass -Command ""$scriptDirectory\RunHidden.ps1""" -WindowStyle Hidden
sleep -Seconds 5

$tempsMax = 60 * 60
$temps = 0

While(((Get-Process -Name "WinSAT") -ne $null) -and ($temps -lt $tempsMax))
{
    sleep -Seconds 30
    $temps += 30
}

$fichier = Get-ChildItem -Path $env:SystemRoot\Performance\WinSAT\DataStore -Recurse | Where-Object { !$PsIsContainer -and [System.IO.Path]::GetFileNameWithoutExtension($_.Name) -like "*Formal.Assessment*" }
$erreur = 1
foreach($f in $fichier)
{
    #Write-Host "Temps modif. : $($f.LastWriteTime) - $((Get-Date).AddMinutes(-5))"
    if($f.LastWriteTime -gt $((Get-Date).AddMinutes(-5)))
    {
        $erreur = 0
    }
}
If(($fichier.Count -ne 0) -and $erreur -eq 0)
{
    #Write-Host "patate"
    If((Test-Path "HKLM:\Software\Policies\WinSat") -eq $false) { New-Item -Path "HKLM:\Software\Policies\WinSat"  }
    New-ItemProperty -Path "HKLM:\Software\Policies\WinSat" -Name "Version" -Value $Version -PropertyType "String" -Force
    $trigger = "{00000000-0000-0000-0000-000000000001}"
    Invoke-WmiMethod -Namespace root\ccm -Class sms_client -Name TriggerSchedule $trigger
}
[CmdletBinding()]    
Param
(        
    [Parameter(Mandatory=$false,
                ValueFromPipelineByPropertyName=$true,
                Position=0)]
    [String]$Version = ''
)

[string]$scriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

$fichier = Get-ChildItem -Path $env:SystemRoot\Performance\WinSAT -Recurse | Where-Object { !$PsIsContainer -and [System.IO.Path]::GetFileNameWithoutExtension($_.Name) -like "*Formal.Assessment*" }
If($fichier.Count -ne 0)
{
    If((Test-Path "HKLM:\Software\Policies\WinSat") -eq $false) { New-Item -Path "HKLM:\Software\Policies\WinSat"  }
    New-ItemProperty -Path "HKLM:\Software\Policies\WinSat" -Name "Version" -Value $Version -PropertyType "String" -Force
    $trigger = "{00000000-0000-0000-0000-000000000001}"
    Invoke-WmiMethod -Namespace root\ccm -Class sms_client -Name TriggerSchedule $trigger
}
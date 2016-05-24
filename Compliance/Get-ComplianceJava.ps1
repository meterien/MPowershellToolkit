# === Josua Baril-Aumond ===
# Modification : 2015-06-05
# Script installation : Detection de la bonne configuration de Java pour desactiver les mises a jour
# Version check : 1

# Definition des variables
$ErrorActionPreference = "SilentlyContinue"
$CurrentLocation = Split-Path -Parent $MyInvocation.MyCommand.Path;
$i = 0
$DeploymentConfig = @("deployment.system.config=file\:C\:/WINDOWS/Sun/Java/Deployment/deployment.properties", "deployment.system.config.mandatory=false")
$DeploymentProperties = @("deployment.user.security.exception.sites=C\:\\WINDOWS\\Sun\\Java\\Deployment\\exception.sites", 
"deployment.expiration.check.enabled=false", 
"deployment.security.mixcode=HIDE_RUN", 
"deployment.insecure.jres=NEVER", 
"deployment.javaws.shortcut=NEVER")

# Verification des cles de registres pour les mises a jour
If((Test-Path "HKLM:\SOFTWARE\Wow6432Node\JavaSoft\Java Update\Policy") -eq $false) { $i ++ }
If((Get-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\JavaSoft\Java Update\Policy" | Select-Object -ExpandProperty "EnableJavaUpdate") -eq 1) { $i ++ }
If((Get-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\JavaSoft\Java Update\Policy" | Select-Object -ExpandProperty "NotifyDownload") -eq 1) { $i ++ }

# Verification des fichiers de configurations
If((Test-Path "$env:systemroot\Sun\Java\Deployment") -eq $false) { $i ++ } 

$ConfigTab = @(Get-Content "$env:systemroot\Sun\Java\Deployment\deployment.config")
Foreach ($Config in $DeploymentConfig)
{
    if(($ConfigTab -notcontains $Config))
    {
        $i ++
    }
}

$PropertiesTab = @(Get-Content "$env:systemroot\Sun\Java\Deployment\deployment.properties")
Foreach($Propertie in $DeploymentProperties)
{
    if($PropertiesTab -notcontains $Propertie)
    {
       $i ++
    }
}

If($i -eq 0)
{
    return 'Compliant'
}
else
{
    return 'NonCompliant'
}
# === Josua Baril-Aumond ===
# Modification : 2015-06-05
# Script installation : Configuration de Java
# Description : ajoute exception pour les vieux et desuets sites java

# Definition des variables
$ErrorActionPreference = "SilentlyContinue"
$CurrentLocation = Split-Path -Parent $MyInvocation.MyCommand.Path;
$DeploymentConfig = "deployment.system.config=file\:C\:/WINDOWS/Sun/Java/Deployment/deployment.properties
deployment.system.config.mandatory=false"
$DeploymentProperties = @("deployment.user.security.exception.sites=C\:\\WINDOWS\\Sun\\Java\\Deployment\\exception.sites", 
"deployment.expiration.check.enabled=false", 
"deployment.security.mixcode=HIDE_RUN", 
"deployment.insecure.jres=NEVER", 
"deployment.javaws.shortcut=NEVER")

# Modification des cles de registres pour empecher les mises a jour automatique
If((Test-Path "HKLM:\SOFTWARE\Wow6432Node\JavaSoft\Java Update\Policy") -eq $false) {New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\JavaSoft\Java Update\Policy" -force }
New-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\JavaSoft\Java Update\Policy" -Name 'EnableJavaUpdate' -Value '0' -PropertyType 'DWord' -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\JavaSoft\Java Update\Policy" -Name 'NotifyDownload' -Value '0' -PropertyType 'DWord' -Force
Start-Process -FilePath "$env:ProgramFiles\Java\jre7\bin\jqs.exe" -ArgumentList "-unregister" -Wait
Start-Process -FilePath "$env:ProgramFiles\Java\jre8\bin\jqs.exe" -ArgumentList "-unregister" -Wait
# Creation des fichiers de configuration
if((Test-Path "$env:systemroot\Sun\Java\Deployment") -ne $true) { 
    New-Item -Path "$env:systemroot\Sun\Java\Deployment" -ItemType 'Directory' -Force
}
if((Test-Path "$env:systemroot\Sun\Java\Deployment\exception.sites") -ne $true) { 
    New-Item -Path "$env:systemroot\Sun\Java\Deployment\exception.sites" -ItemType 'File' -Value "" -Force 
}
New-Item -Path "$env:systemroot\Sun\Java\Deployment\deployment.config" -ItemType 'File' -Value $DeploymentConfig -Force
if((Test-Path "$env:systemroot\Sun\Java\Deployment\deployment.properties") -ne $true) { 
    New-Item -Path "$env:systemroot\Sun\Java\Deployment\deployment.properties" -ItemType 'File' -Value "" -Force
}
$Contenu = @(Get-Content "$env:systemroot\Sun\Java\Deployment\deployment.properties")
# Si le fichier est vide
if($Contenu.Count -lt 1)
{
    # Ajouter les proprietes au fichier
    $DeploymentProperties | Out-File -FilePath "$env:systemroot\Sun\Java\Deployment\deployment.properties" -Force
}
# Sinon
else
{
    # Permet que la premiere propriete ajoute soit sur une nouvelle ligne 
    $NouvelleLigne = "`n"
    Foreach($Propertie in $DeploymentProperties)
    {
        if($Contenu -notcontains $Propertie)
        {
            $Texte = $NouvelleLigne + $Propertie
            Add-Content -Path "$env:systemroot\Sun\Java\Deployment\deployment.properties" -Value $Texte -Force
            $NouvelleLigne = ""
        }
    }
}
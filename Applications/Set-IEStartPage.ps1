# Auteur      : Josua Baril-Aumond
# Date        : 2015-10-07
# Description : Charge la ruche DefaultUser et appliquer des modifications
param(
    [String]$IEStartPage = "www.google.ca"
)

# Variables
[String]$HKDefault = "HKU\DefaultProfile"
[String]$HKNTUserDAT = "$env:SystemDrive\Users\Default\NTUSER.DAT"


# Load and add a Registry PSDrive
REG LOAD $HKDefault $HKNTUserDAT
New-PSDrive -Name HKDefaultUser -PSProvider Registry -Root $HKDefault
CD HKDefaultUser:

# Make my modification
If(-not (Test-Path "$HKDefault\Software\Microsoft\Internet Explorer\Main")) { New-Item -Path "$HKDefault\Software\Microsoft\Internet Explorer\Main" -Force }
New-ItemProperty -Path "$HKDefault\Software\Microsoft\Internet Explorer\Main" -Name "Start Page" -PropertyType String -Value $IEStartPage -Force

# Unload and remove the Registry PSDrive
ls Env: | Out-Null
ls Variable: | Out-Null
CD c:
Remove-PSDrive HKDefaultUser
REG UNLOAD $HKDefault
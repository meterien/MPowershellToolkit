param(
    $softwareName,
    $whatIf = $true
)

$null = New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
$RegUninstallPaths = @( 
    'HKCR:\HKCR:\Installer',
    'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall', 
    'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall'
    'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData',
    'HKLM:\SOFTWARE\Classes\Installer\Products'
) 
$UninstallSearchFilter = { ($_.GetValue('DisplayName') -like "*$softwareName*") -or ($_.GetValue('ProductName') -like "*$softwareName*")} 
foreach ($Path in $RegUninstallPaths) { 
    if (Test-Path $Path) { 
        $items = Get-ChildItem $Path -Recurse | Where $UninstallSearchFilter
        if($whatIf) {
            $i = 0
            for($i -eq 0 ; $i -lt $items.Count ; $i ++) {
                $item = Get-ItemProperty $items[$i].PSPath
                Write-Host $($item.DisplayName + " => " + $item.DisplayVersion)
            }
        }
        else {
            $items | Remove-Item -Recurse
            for($i -eq 0 ; $i -lt $items.Count ; $i ++) {
                $item = Get-ItemProperty $items[$i].PSPath
                Write-Host "Removed : $($item.DisplayName + " => " + $item.DisplayVersion)"
            }
        }
    } 
}
$null = Remove-PSDrive -Name HKCR
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:PUBLIC\Desktop\Redémarrer.lnk")
$Shortcut.TargetPath = "Shutdown.exe"
$Shortcut.Arguments =  "-r -t 00"
$Shortcut.IconLocation = "c:\Windows\system32\SHELL32.dll, 27"
$Shortcut.Save()
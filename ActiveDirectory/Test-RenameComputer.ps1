$ar = New-Object System.Collections.Generic.List[System.Object]
$computersList = Get-ADComputer -Filter *
foreach($pc in $computersList)
{
    $display = New-Object System.Object
    $oldName = $pc.Name
    $display | Add-Member -type NoteProperty -name Debut -value $oldName
    $newName = ""
    $newName = $oldName.Substring(1)
    $newName = "Z$($newName)"
    $display | Add-Member -type NoteProperty -name Fin -value $newName
    $ar.Add($display)
}
$ar | ConvertTo-Csv -Delimiter ' ' | Out-File -FilePath .\Excel.csv
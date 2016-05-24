# Must have access to ImportExcel module

$sourceFolder = ".\Sources"
$excelFile = ".\Applications.xlsx"

Import-Module ".\Modules\ImportExcel"

#--- TODO Take a backup a the file \\folder\file.date.hh.mm.ss.xslx

#--- TODO Hash table for the fields names

$softwareList = Import-Excel -Path $excelFile

Write-Host "========="
#foreach($App in $softwareList)
for($i = 0 ; $i -lt $softwareList.Count ; $i ++)
{
    if($softwareList[$i].'Nom court' -ne '' -and $softwareList.Actif -eq 'Oui' -and $softwareList.'Vérifier' -eq 'Oui')
    {
        Write-Host "$($softwareList[$i].'Nom')"
        $foundApp = Find-Package -Name "$($softwareList[$i].'Nom court')"
        if($foundApp)
        {
            if($softwareList[$i].Nouvelle -eq '') { $softwareList[$i].Nouvelle = '0.0' }
            Write-Host "($($softwareList[$i].Nouvelle) => $($foundApp.Version))"
            if([version]$foundApp.Version -gt [version]$softwareList[$i].Nouvelle)
            {
                $softwareList[$i].Nouvelle = $foundApp.Version
            }
        }
        else
        {
            Write-Host "Application non trouvé"
        }
    }
}

#$softwareList | Export-Excel -Path "D:\Projets\Automatisation-ExcelLogiciels\Sortie.xlsx" -BoldTopRow -AutoFilter -FreezeTopRow -AutoSize
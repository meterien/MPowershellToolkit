# Must have ActiveDirectory and ImportExcel module available

Import-Module ActiveDirectory
Import-Module .\ImportExcel

$ar = New-Object System.Collections.Generic.List[System.Object]
$displayList = @()

$searchOU = ""

$usersList = Get-ADUser -searchbase $searchOU -searchscope 1 -Filter * -Properties givenName, sn, displayName, description

foreach($user in $usersList)
{
    $tmpuser = New-Object System.Object
    $firstName = $user.GivenName
    $lastName = $user.sn
    $completeName = $user.DisplayName
    $description = $user.Description
    $name = $user.Name
    $sAMAccountName = $user.SamAccountName
    $newName = ""
    if($firstName -and $lastName) { $newName = "$firstName $lastName" }

    $tmpuser | Add-Member -type NoteProperty -name 'Prénom (affiché)' -value $firstName
    $tmpuser | Add-Member -type NoteProperty -name 'Nom (affiché)' -value $lastName
    $tmpuser | Add-Member -type NoteProperty -name 'Nom complet (affiché)' -value $completeName
    $tmpuser | Add-Member -type NoteProperty -name 'Description (affiché)' -value $description
    $tmpuser | Add-Member -type NoteProperty -name 'Nom (propriété)' -value $name
    $tmpuser | Add-Member -type NoteProperty -name 'Nouveau nom' -value $newName
    $tmpuser | Add-Member -type NoteProperty -name 'SamAccountName (propriété)' -value $sAMAccountName

    # Ajouté les entrées qui correspondent à :

    # Tous
        #$ar.Add($tmpuser)
        $displayList += $tmpuser

    # La propriété nom n'égale pas le prénom espace le nom de famille
        #if($name -ne "$firstName $lastName") { $ar.Add($tmpuser) }

    # Le champ description est vide
        #if($description -like "") { $ar.Add($tmpuser) }

    # La propriété nom est égale au sAMAccountName
        #if($name -eq $sAMAccountName) { $ar.Add($tmpuser) }
}

$displayList | Out-GridView
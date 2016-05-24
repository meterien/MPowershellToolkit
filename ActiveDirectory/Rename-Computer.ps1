param(
    [String]$Fichier = ".\password.bin",
    [String]$Key = ".\key.bin",
    [String]$username
)

function Store-SecureSrtringFrom-Text([String]$m_Fichier)
{
    # Capture once and store to file
    $passwd = Read-Host "Enter password" -AsSecureString
    $encpwd = ConvertFrom-SecureString $passwd
    $encpwd > $m_Fichier
}

function Get-SecureStringFrom-File($m_Fichier)
{
    # Later pull this in and restore to a secure string
    $encpwd = Get-Content $m_Fichier
    #$passwd = ConvertTo-SecureString $encpwd
    return $encpwd
}

function Decrypt-SecureStringTo-Text($passwd)
{
    # Extract a plain text password from secure string
    $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($passwd)
    $str =  [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($bstr)
    [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($bstr)
    return $str
}

Function RandomKey {
     $RKey = @()
     For ($i=1; $i -le 16; $i++) {
        [Byte]$RByte = Get-Random -Minimum 0 -Maximum 256
        $RKey += $RByte
     }
     $RKey
}

$Cle = Get-Content $Key
$EncryptedPW = Get-SecureStringFrom-File -m_Fichier $Fichier
$passMontage = ConvertTo-SecureString -String $EncryptedPW -Key $Cle
$cred = New-Object System.Management.Automation.PSCredential $username, $passMontage

$AncienNom = $env:computername
$NouveauNom = ""
$NouveauNom = $AncienNom.Substring(1)
$NouveauNom = "Z$($NouveauNom)"
if($AncienNom -ne $NouveauNom)
{
    $Objet = gwmi win32_computersystem -Authentication 6
    $erreur = $Objet.Rename($NouveauNom, $cred.GetNetworkCredential().Password, $($cred.GetNetworkCredential().UserName))
    Exit $erreur.ReturnValue
}
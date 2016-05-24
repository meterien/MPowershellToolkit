param(
    [String]$computerName = $env:COMPUTERNAME,
    [String]$newDescription = "",
    [String]$userName = "",
    [String]$passwordFile = ".\password.bin",
    [String]$Key = ".\key.bin"
)

function Store-SecureSrtringFrom-Text([String]$m_file)
{
    # Capture once and store to file
    $passwd = Read-Host "Enter password" -AsSecureString
    $encpwd = ConvertFrom-SecureString $passwd
    $encpwd > $m_file
}

function Get-SecureStringFrom-File($m_file)
{
    # Later pull this in and restore to a secure string
    $encpwd = Get-Content $m_file
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

$keyContent = Get-Content $Key
$EncryptedPW = Get-SecureStringFrom-File -m_Fichier $passwordFile
$userPassword = ConvertTo-SecureString -String $EncryptedPW -Key $keyContent
$cred = New-Object System.Management.Automation.PSCredential $userName, $userPassword

# Create an ADSI Search    
$Searcher = New-Object -TypeName System.DirectoryServices.DirectorySearcher

# Get only the Group objects
$Searcher.Filter = "(&(objectCategory=Computer)(Name=$computerName))"

# Limit the output to 1 objects
$Searcher.SizeLimit = '1'

# Get the current domain
$DomainDN = $(([adsisearcher]"").Searchroot.path)

# Create an object "DirectoryEntry" and specify the domain, username and password
$Domain = New-Object -TypeName System.DirectoryServices.DirectoryEntry -ArgumentList $DomainDN ,$($Credential.UserName),$($Credential.GetNetworkCredential().password)

# Add the Domain to the search
$Searcher.SearchRoot = $Domain

# Execute the Search
$computer = $Searcher.FindOne()

# Get old description
$oldDesc = $computer.Properties.description

# Set the new desciption
$newDescription = $newDescription.Replace("'", "''")
$computer.Properties.description = $newDescription

# Commit change
$computer.SetInfo()
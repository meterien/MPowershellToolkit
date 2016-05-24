param(
    [Parameter(Mandatory=$true)]
    [String]$folder,
    [Parameter(Mandatory=$true)]
    [String]$user,
    [Parameter(Mandatory=$true)]
    [String]$permission,
    [Parameter(Mandatory=$true)]
    [ValidateSet("Allow", "Denied")]
    [String]$type = "Allow",
    [Parameter(Mandatory=$true)]
    [Switch]$recurse = $true
)

# Define the correct permissions
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule($user, $permission, $type)

if($recurse)
{
    $folders = Get-ChildItem $folder -Recurse -Force

    foreach($file in $folders)
    {
        $acl = $file.GetAccessControl('Access')
        $acl.SetAccessRule($rule)
        Set-Acl $file.FullName $acl
    }
}
else
{
    $setFolder = Get-Item -Path $folder
    $acl = $setFolder.GetAccessControl('Access')
    $acl.SetAccessRule($rule)
    Set-Acl $setFolder.FullName $acl
}

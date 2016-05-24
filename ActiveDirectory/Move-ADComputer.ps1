 <#

.SYNOPSIS
    
Move a computer in Active Directory based on task sequence variables (OSDDomainOUName) or the organisationnal unit in parameter.

.PARAMETER newOU

The destination organisationnal unit

.PARAMETER computerName

The computer name to move

.PARAMETER fichier

The file that contain an encrypted password for the Active Directory account

.PARAMETER key

The key to decrypt the password

.PARAMETER domainController

The server hosting the Active Directory
    
.EXAMPLE

Move the local computer to an OU defined in task sequence variables
    
Move-ADComputer -domainController "dc1.tatoo.com"

.EXAMPLE

Move a computer named R2D2-CHEWBACCA to OU=Ordinateur,OU=Accounting,DC=tatoo,DC=com

Move-ADComputer -newOU "OU=Ordinateur,OU=Accounting,DC=tatoo,DC=com" -computerName R2D2-CHEWBACCA -domaineController "dc1.tatoo.com"

.NOTES

This script need to have access the a subfolder named "PSModules" which contains the following powershell modules : Microsoft.BDD.TaskSequenceModule and QuestAD17 (Dell Active Role AD v1.7)

#>
[CmdletBinding()]
param( 
    [String]$newOU = "",                       # Organizational unit
    [String]$computerName = $env:COMPUTERNAME, # Computer name to move
    [String]$user,                             # User account to access AD
    [String]$file = "",                        # File that contain a encrypted password
    [String]$Key = "",                         # Encryption key of the password
    [parameter(Mandatory=$True)] 
    [String]$domainController = ""             # Domain controller
)

# Definitions des fonctions ----------------------------------------
Function Log-ScriptEvent 
{ 
    #Define and validate parameters 
    [CmdletBinding()] 
    Param( 
        #Path to the log file 
        [parameter(Mandatory=$True)] 
        [String]$NewLog,  
        #The information to log 
        [parameter(Mandatory=$True)] 
        [String]$Value,  
        #The source of the error 
        [parameter(Mandatory=$True)] 
        [String]$Component,  
        #The severity (1 - Information, 2- Warning, 3 - Error) 
        [parameter(Mandatory=$True)] 
        [ValidateRange(1,3)] 
        [Single]$Severity 
    ) 
 
    #Obtain UTC offset 
    $DateTime = New-Object -ComObject WbemScripting.SWbemDateTime  
    $DateTime.SetVarDate($(Get-Date)) 
    $UtcValue = $DateTime.Value 
    $UtcOffset = $UtcValue.Substring(21, $UtcValue.Length - 21) 
 
    #Create the line to be logged 
    $LogLine =  "<![LOG[$Value]LOG]!><time=""$(Get-Date -Format HH:mm:ss.fff)$($UtcOffset)"" date=""$(Get-Date -Format M-d-yyyy)"" component=""$Component"" context=""$([System.Security.Principal.WindowsIdentity]::GetCurrent().Name)"" type=""$Severity"" thread=""$([Threading.Thread]::CurrentThread.ManagedThreadId)"" file="""">" 
 
    #Write the line to the passed log file 
    $Sw = New-Object System.IO.StreamWriter $NewLog, true
    $Sw.WriteLine($LogLine)
    $Sw.Close()
} 

Function Move-Computer
{
    param(
        $name, 
        $targetOU,
        $credential,
        $DC
    )

    $computerDN = ""
    $startUnit = ""
    $connexionOutput = Connect-QADService -Service $DC -Credential $credential
    Log-ScriptEvent -Value "Connect to domain : $($connexionOutput.Domain)" -Severity 1 -Component "Informations" -NewLog $logName
    Log-ScriptEvent -Value "Computer search : $name" -Severity 1 -Component "Informations" -NewLog $logName
    $computer = Get-QADComputer $name

    if($computer)
    {
        # Find the good one if multiple entries
        if($computer.Count)
        {
            foreach($comp in $computer)
            {
                if($comp.DN.Contains("CN=$name,"))
                {
                    $computerDN = $comp.DN
                    $startUnit = $comp.ParentContainerDN
                }
            }
        }
        else
        {
            $computerDN = $computer.DN
            $startUnit = $computer.ParentContainerDN
        }
        Log-ScriptEvent -Value "Ok DN : $computerDN" -Severity 1 -Component "Informations" -NewLog $logName
        Log-ScriptEvent -Value "Start OU : $startUnit" -Severity 1 -Component "Informations" -NewLog $logName
        Log-ScriptEvent -Value "Destination OU : $targetOU" -Severity 1 -Component "Informations" -NewLog $logName
        if($targetOU -and $computerDN)
        {
            if($startUnit -eq $targetOU)
            {
                Log-ScriptEvent -Value "No action required" -Severity 1 -Component "Informations" -NewLog $logName
            }
            else
            {
                $res = Move-QADObject -Identity $computerDN -NewParentContainer $targetOU
                Log-ScriptEvent -Value "Computer move to : $res" -Severity 1 -Component "Informations" -NewLog $logName
            }
        }
        else
        {
            Log-ScriptEvent -Value "No action required, OU not available" -Severity 1 -Component "Informations" -NewLog $logName
        }
    }
    else
    {
        Log-ScriptEvent -Value "Computer $name not found" -Severity 1 -Component "Informations" -NewLog $logName
    }

    Disconnect-QADService
}

function Get-SecureStringFrom-File($m_file)
{
    $encpwd = Get-Content $m_file
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

# Variables defined ----------------------------------------
$startTime = Get-Date
if(Test-Path -Path "$env:windir\Logs\Software") # WinDir non trouve pendant une TS
{ 
    $loggingFolder = "$env:windir\Logs\Software" 
}
else
{
    $loggingFolder = "C:\Windows\Logs\Software"
}
$logName = "$loggingFolder\Move-ADComputer-$(Get-Date -Format "MM-dd-yyyy").Log"
$scriptFolder = Split-Path -Parent $MyInvocation.MyCommand.Path;

# Logging start
Log-ScriptEvent -Value "==================" -Severity 1 -Component "Informations" -NewLog $logName
Log-ScriptEvent -Value "Start of execution : $startTime" -Severity 1 -Component "Informations" -NewLog $logName
Log-ScriptEvent -Value "------------------------------------" -Severity 1 -Component "Informations" -NewLog $logName
Log-ScriptEvent -Value "Current folder : $scriptFolder" -Severity 1 -Component "Informations" -NewLog $logName

# Gather identification informations
$Key = "$scriptFolder\key.bin"
$file = "$scriptFolder\password.bin"
if((Get-Item -Path $key -ErrorAction SilentlyContinue) -and (Get-Item -Path $file -ErrorAction SilentlyContinue))
{
    $keyContent = Get-Content $Key
    $EncryptedPW = Get-SecureStringFrom-File -m_Fichier $file
    $userPassword = ConvertTo-SecureString -String $EncryptedPW -Key $keyContent
    $cred = New-Object System.Management.Automation.PSCredential -ArgumentList $user, $userPassword
    Log-ScriptEvent -Value "ID : key.bin and password.bin are valid" -Severity 1 -Component "Informations" -NewLog $logName
}
else
{
    Log-ScriptEvent -Value "ID : key.bin and password.bin not found" -Severity 1 -Component "Informations" -NewLog $logName
}
Log-ScriptEvent -Value "User account (AD) : $($cred.Username)" -Severity 1 -Component "Informations" -NewLog $logName
Log-ScriptEvent -Value "Domain controller : $domainController" -Severity 1 -Component "Informations" -NewLog $logName
Log-ScriptEvent -Value "------------------------------------" -Severity 1 -Component "Informations" -NewLog $logName

# Import modules
$ztiOutput = Import-Module "$scriptFolder\PSModules\Microsoft.BDD.TaskSequenceModule" -ErrorAction SilentlyContinue -PassThru
Log-ScriptEvent -Value "Module ZTIUtility loaded : $($ztiOutput.Name)" -Severity 1 -Component "Informations" -NewLog $logName
$questOutput = Import-Module "$scriptFolder\PSModules\QuestAD17\Quest.ActiveRoles.ArsPowerShellSnapIn.dll" -ErrorAction SilentlyContinue -PassThru
Log-ScriptEvent -Value "Module QuestAD 1.7 loaded : $($questOutput.Name)" -Severity 1 -Component "Informations" -NewLog $logName
Log-ScriptEvent -Value "------------------------------------" -Severity 1 -Component "Informations" -NewLog $logName

# If param OU is not present, search in TSENV
if($newOU -eq "")
{
    Log-ScriptEvent -Value "OU : not found, search in TSENV" -Severity 1 -Component "Informations" -NewLog $logName
    $taskSequenceVariables = Get-ChildItem TSEnv: -ErrorAction SilentlyContinue
    if($taskSequenceVariables)
    {
        Log-ScriptEvent -Value "Variables list" -Severity 1 -Component "Informations" -NewLog $logName
        foreach($var in $taskSequenceVariables)
        {
            if(-not $($var.Name).Contains("_SMSTS"))
            {
                Log-ScriptEvent -Value "* $($var.Name) : $($var.Value)" -Severity 1 -Component "Informations" -NewLog $logName
            }
            if($var.Name -eq "OSDDomainOUName")
            {
                $newOU = $var.Value
            }
        }
    }
    else
    {
        Log-ScriptEvent -Value "* Variables not found" -Severity 1 -Component "Informations" -NewLog $logName
    }
}
else
{
    Log-ScriptEvent -Value "Error : no OU found" -Severity 1 -Component "Informations" -NewLog $logName
}
Log-ScriptEvent -Value "------------------------------------" -Severity 1 -Component "Informations" -NewLog $logName

# User account validation
if($cred.Username)
{
    Log-ScriptEvent -Value "ID : Ok" -Severity 1 -Component "Informations" -NewLog $logName
    Log-ScriptEvent -Value "------------------------------------" -Severity 1 -Component "Informations" -NewLog $logName
    Move-Computer -name $computerName -targetOU $newOU -credential $cred -DC $domainController
}
else
{
    Log-ScriptEvent -Value "ID : invalid" -Severity 1 -Component "Informations" -NewLog $logName
}

# End of logging
Log-ScriptEvent -Value "------------------------------------" -Severity 1 -Component "Informations" -NewLog $logName
Log-ScriptEvent -Value "End of execution : $(Get-Date) ----" -Severity 1 -Component "Informations" -NewLog $logName
Log-ScriptEvent -Value "Execution length : $(NEW-TIMESPAN –Start $startTime –End $(Get-Date)) ----" -Severity 1 -Component "Informations" -NewLog $logName

Param(
    [String]$logLocation = "$env:SystemRoot\Logs\Software",
    [String]$logName = "$logLocation\MCast-Monitoring.Log"
)
# Definition des fonctions
Function Log-ScriptEvent { 
    [CmdletBinding()] 
    Param( 
        # Chemin du journal
        [parameter(Mandatory=$True)] 
        [String]$NewLog,  
        # Informations 
        [parameter(Mandatory=$True)] 
        [String]$Value,  
        # La source de l'erreur 
        [parameter(Mandatory=$True)] 
        [String]$Component,  
        # Niveau  (1 - Information, 2- Avertissement, 3 - Erreur) 
        [parameter(Mandatory=$True)] 
        [ValidateRange(1,3)] 
        [Single]$Severity 
    ) 
 
    # Determine le decalage horaire
    $DateTime = New-Object -ComObject WbemScripting.SWbemDateTime  
    $DateTime.SetVarDate($(Get-Date)) 
    $UtcValue = $DateTime.Value 
    $UtcOffset = $UtcValue.Substring(21, $UtcValue.Length - 21) 
 
    # Création d'une ligne du journal
    $LogLine =  "<![LOG[$Value]LOG]!>" +` 
                "<time=`"$(Get-Date -Format HH:mm:ss.fff)$($UtcOffset)`" " +` 
                "date=`"$(Get-Date -Format M-d-yyyy)`" " +` 
                "component=`"$Component`" " +` 
                "context=`"$([System.Security.Principal.WindowsIdentity]::GetCurrent().Name)`" " +` 
                "type=`"$Severity`" " +` 
                "thread=`"$([Threading.Thread]::CurrentThread.ManagedThreadId)`" " +` 
                "file=`"`">" 
 
    # Écriture de la ligne dans un fichier
    $Sw = New-Object System.IO.StreamWriter $NewLog, true
    $Sw.WriteLine($LogLine)
    $Sw.Close()
} 

# Get monitoring data from a namespace ID
function Get-NamespaceData
{
    
    # Get data from $global:currentNamespace
    if($global:currentNamespace -ne "-1")
    {
        #Create an array to hold all Clients in the stream
	    [array]$Clients = $null
   
	    #Create a Hashtable to format the list for Out-Gridview used later
        $CliFormat = @{Label="Master Client";Expression={($_.Id -eq $session.MasterClientId)}},
            @{Label="Id";Expression={$_.Id}}, 
	        @{Label="Name";Expression={$_.Name}},
	        @{Label="MacAddress";Expression={$_.MacAddress}}, 
	        @{Label="IpAddress";Expression={$_.IpAddress}}, 
	        @{Label="PercentCompletion";Expression={$_.PercentCompletion}}, 
	        @{Label="JoinDuration";Expression={$_.JoinDuration}}, 
	        @{Label="CpuUtilization";Expression={$_.CpuUtilization}}, 
	        @{Label="MemoryUtilization";Expression={$_.MemoryUtilization}}, 
	        @{Label="NetworkUtilization";Expression={$_.NetworkUtilization}},
	        @{Label="TransferRate";Expression={[Int]($session.TransferRate / 1024)}}

        $wdsNmSpcs = $global:wdsServer.NamespaceManager.RetrieveNamespaces("","",$false)
        $i = 1
        for($i -eq 1 ; $i -lt ($wdsNmSpcs.Count + 1) ; $i ++)
        {
            if(($wdsNmSpcs.Item($i).id) -eq $global:currentNamespace)
            {
                $ContentsColl = $wdsNmSpcs.Item($i).RetrieveContents()
            }
        }
        
        #Make sure the stream is valid and has clients connected
        if($ContentsColl.Count-ne 0)
        {
            # Assume the $ContentsColl only contains 1 Item when using WDS with SCCM
            $list = New-Object System.Collections.ArrayList
            $Countj = $ContentsColl.Count
            $ContentsColl.Count
            for ($j=1; $j -lt ($Countj + 1); $j++)
            {
                $content = $ContentsColl.Item($j)
                $sessioncoll = $content.RetrieveSessions()
        
                # Assume the $sessioncoll only contains 1 Item when using WDS with SCCM
                $Countk = $sessioncoll.Count
                $sessioncoll.Count
                for ($k=1; $k -lt ($Countk + 1); $k++)
                {
                    $session = $sessioncoll.Item($k)
                    $ClientColl = $session.RetrieveClients()
                        
                    #Make sure there are clients connected to the stream
                    If ($ClientColl.Count -ne 0)
                    {
                        $Count = $ClientColl.Count
                        for ($i=1; $i -lt ($Count + 1); $i++)
                        {
                
                           if ($Clients -eq $null)
                            {
                                $Clients = $ClientColl.Item($i) 
                                $list.Add($ClientColl.Item($i))
                            }
                            else
                            {
                                #$Clients = $Clients + $ClientColl.Item($i) 
                                $list.Add($ClientColl.Item($i))
                            }
                        }
                        # Output the result using a custom formated Out-GridView
                        $transrate = [Int]($session.TransferRate / 1024)
				
                        # Set the DGV data
                        $myArray = New-Object System.Collections.ArrayList
                        foreach($client in $list)
                        {
                            if($client.id -ne "")
                            {
                                $myArray.Add(($client | Select-Object -property $CliFormat))
                            }
                        }
                        $WPFdgvMonitoring.ItemsSource = $myArray
                        $Clients = $null
                    }
                    else
                    {
                        #[System.Windows.Forms.MessageBox]::Show("Cet espace de nom ne contient aucun client connecté.","Information")
                    }
                }
            }
        }
        else
        {
            $WPFdgvMonitoring.ItemsSource = $null
           [System.Windows.Forms.MessageBox]::Show("Cet espace de nom ne contient aucun client connecté.","Information") 
        }
    }
    else
    {
        [System.Windows.Forms.MessageBox]::Show("Il n'y a pas d'espace de nom en cours.","Information")
    }
}

# Change the namespace
function Set-CurrentNamespace
{
    param(
        [String]$Id
    )
    $global:currentNamespace = $Id
}

# Get all namespace
function Get-AllNamespace
{
    $wdsNmSpcs = $global:wdsServer.NamespaceManager.RetrieveNamespaces("","",$false)
    $i = 1
    if($wdsNmSpcs.Count -eq 1 -or $wdsNmSpcs.Count -gt 1)
    {
        $WPFbtnRefreshDGV.IsEnabled = $true
        $WPFbtnRemoveClient.IsEnabled = $true
        $WPFckbAuto.IsEnabled = $true
        $WPFbtnViewClients.IsEnabled = $true
        $WPFtxtRemoveClient.IsEnabled = $true
        $WPFcbxNamespace.IsEnabled = $true
        $WPFcbxNamespace.Items.Clear()
        for($i -eq 1 ; $i -lt ($wdsNmSpcs.Count + 1) ; $i ++)
        {
            $WPFcbxNamespace.Items.Add($wdsNmSpcs.Item($i).id)
        }
        $WPFcbxNamespace.SelectedIndex = 0
        Set-CurrentNamespace -Id $WPFcbxNamespace.SelectedValue | Out-Null
        $WPFdgvMonitoring.ItemsSource = $null
        $WPFdgvMonitoring.Items.Clear()
        Get-NamespaceData | Out-Null
    }
    else
    {
        $WPFbtnRefreshDGV.IsEnabled = $false
        $WPFbtnRemoveClient.IsEnabled = $false
        $WPFckbAuto.IsEnabled = $false
        $WPFbtnViewClients.IsEnabled = $false
        $WPFtxtRemoveClient.IsEnabled = $false
        $WPFcbxNamespace.IsEnabled = $false
    }
}

# Remove a client from a namespace
function Remove-ClientFromNamespace
{
    param(
        [String]$id = "-1"
    )
    if($id -ne "-1")
    {
        $exec = Start-Process -FilePath "WDSUTIL" -ArgumentList "/disconnect-client /ClientID:$id" -PassThru
        if($exec -ne "")
        {
            [System.Windows.Forms.MessageBox]::Show("Le client $id a été retiré.","Information")
        }
        else
        {
            [System.Windows.Forms.MessageBox]::Show("Erreur : $exec","Information") 
        }
    }
    else
    {
        [System.Windows.Forms.MessageBox]::Show("Aucun client valide sélectionné","Information")
    }
}

# View all client from a namespace
function Get-ClientFromNamespace
{
    #$exec = Start-Process -FilePath "WDSUTIL" -ArgumentList "/get-allnamespaces /details:Clients" -PassThru
    $wdsNmSpcs = $global:wdsServer.NamespaceManager.RetrieveNamespaces("","",$false)
    $wdsNmSpcs.Item(1) | Out-GridView
    <#if($exec)
    {
        $exec | Out-GridView
    }
    else
    {
        [System.Windows.Forms.MessageBox]::Show("Erreur : Aucun client trouvé","Information") 
    }#>
}

# Start the timer
function Start-Timer()
{ 
    Register-ObjectEvent -InputObject $global:timer -EventName Elapsed -SourceIdentifier theTimer -Action { Get-NamespaceData }
    $global:timer.start()
}

# Stop the timer and clean
function Stop-Timer()
{
    $global:timer.stop()
    Unregister-Event theTimer
}

# Initialisation des variables et debut de la journalisation
$StartDate = Get-Date
$Date2= Get-Date -Format "MM-dd-yyyy" 
[string]$global:scriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

# Prepare the WPF form
$inputXML = @"
<Window x:Class="MCAST_Monitoring.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:MCAST_Monitoring"
        mc:Ignorable="d"
        Title="Monitoring multicast session" Height="432" Width="544">
    <Grid>
        <DataGrid x:Name="dgvMonitoring" Margin="10,92,10,10"/>
        <Button x:Name="btnRefreshDGV" Content="Refresh data" HorizontalAlignment="Left" Margin="10,67,0,0" VerticalAlignment="Top" Width="130"/>
        <Button x:Name="btnRefreshNamespace" Content="Refresh namespace" HorizontalAlignment="Left" Margin="10,20,0,0" VerticalAlignment="Top" Width="170"/>
        <ComboBox x:Name="cbxNamespace" Margin="190,20,0,0" VerticalAlignment="Top" Height="20" HorizontalAlignment="Left" Width="175"/>
        <CheckBox x:Name="ckbAuto" Content="Auto (2 sec.)" HorizontalAlignment="Left" Margin="145,70,0,0" VerticalAlignment="Top"/>
        <Button x:Name="btnRemoveClient" Content="Remove selected client" Margin="0,67,140,0" VerticalAlignment="Top" HorizontalAlignment="Right" Width="142"/>
        <TextBox x:Name="txtRemoveClient" Height="18" Margin="0,67,10,0" TextWrapping="Wrap" VerticalAlignment="Top" HorizontalAlignment="Right" Width="115"/>
        <Button x:Name="btnViewClients" Content="View clients" HorizontalAlignment="Left" Margin="411,20,0,0" VerticalAlignment="Top" Width="115"/>
    </Grid>
</Window>
"@       
 
$inputXML = $inputXML -replace 'mc:Ignorable="d"','' -replace "x:N",'N'  -replace '^<Win.*', '<Window'
[void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
[xml]$XAML = $inputXML
 $reader=(New-Object System.Xml.XmlNodeReader $xaml) 
try
{
    $Form=[Windows.Markup.XamlReader]::Load( $reader )
}
catch [Exception]
{
    Write-Host "Unable to load Windows.Markup.XamlReader. Double-check syntax and ensure .net is installed."
    Write-Host $_.Exception
}
 
#===========================================================================
# Load XAML Objects In PowerShell
#===========================================================================
 
$xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name "WPF$($_.Name)" -Value $Form.FindName($_.Name)}
 
Function Get-FormVariables{
    if ($global:ReadmeDisplay -ne $true){Write-host "If you need to reference this display again, run Get-FormVariables" -ForegroundColor Yellow;$global:ReadmeDisplay=$true}
    write-host "Found the following interactable elements from our form" -ForegroundColor Cyan
    get-variable WPF*
}
 
Get-FormVariables
 
#===========================================================================
# Actually make the objects work
#===========================================================================

# Form control initialization

#Create the WDS Com Object
$wdsObject = New-Object -ComObject WdsTptMgmt.WdsTransportManager
$global:wdsServer = $wdsObject.GetWdsTransportServer("localhost")

# First get the namespace

Get-AllNamespace

$WPFbtnRefreshDGV.Content = "Rafraichir les données"
$WPFbtnRefreshNamespace.Content = "Rafraichir les espaces de nom"
$WPFdgvMonitoring.Columns | Foreach-Object{
    $_.AutoSizeMode = [System.Windows.Forms.DataGridViewAutoSizeColumnMode]::AllCells
}
$WPFdgvMonitoring.CanUserAddRows = $false

$WPFbtnViewClients.Content = "Informations"

$global:timer = New-Object System.Windows.Forms.Timer
$global:timer.Interval = 3000
$global:timer.Add_tick({ Get-NamespaceData })

# Form functions
$WPFbtnRefreshDGV.Add_Click({
    Get-NamespaceData
})
$WPFbtnRefreshNamespace.Add_Click({
    Get-AllNamespace
})
$WPFcbxNamespace.Add_SelectionChanged({
    Set-CurrentNamespace -Id $WPFcbxNamespace.SelectedValue
})
$WPFckbAuto.Add_Checked({
    if($global:currentNamespace -ne "-1")
    {
        $WPFbtnRefreshDGV.IsEnabled = $false
        $global:timer.Start()
    }
})
$WPFckbAuto.Add_UnChecked({
    if($global:currentNamespace -ne "-1")
    {
        $WPFbtnRefreshDGV.IsEnabled = $true
        $global:timer.Stop()
    }
})
$WPFbtnRemoveClient.Add_Click({
    $anId = "-1"
    $anId = $WPFtxtRemoveClient.Text
    Remove-ClientFromNamespace -id $anId
})
 $WPFbtnRemoveClient.Add_Click({
    
})
$WPFbtnViewClients.Add_Click({
    Get-ClientFromNamespace
})

$Form.Add_Closed({
    $WPFdgvMonitoring.ItemsSource = $null
})

#===========================================================================
# Shows the form
#===========================================================================
$Form.ShowDialog() | out-null
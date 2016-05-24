$AppsList = @("Microsoft.BingFinance",
                "Microsoft.BingNews",
                "Microsoft.BingWeather",
                "Microsoft.XboxApp",
                "Microsoft.SkypeApp",
                "Microsoft.MicrosoftSolitaireCollection",
                "Microsoft.BingSports",
                "Microsoft.ZuneMusic",
                "Microsoft.ZuneVideo",
                "Microsoft.Windows.Photos",
                "Microsoft.People",
                "Microsoft.MicrosoftOfficeHub",
                "Microsoft.WindowsMaps",
                "microsoft.windowscommunicationsapps",
                "Microsoft.Getstarted",
                "Microsoft.3DBuilder",
                "Microsoft.WindowsFeedback",                                  
                "9E2F88E3.Twitter",                       
                "king.com.CandyCrushSodaSaga")            


ForEach ($App in $AppsList)
{
    $PackageFullName = (Get-AppxPackage $App).PackageFullName
    $ProPackageFullName = (Get-AppxProvisionedPackage -online | where {$_.Displayname -eq $App}).PackageName
    write-host $PackageFullName
    Write-Host $ProPackageFullName
    if ($PackageFullName)
    {
        Write-Host "Removing Package: $App"
        remove-AppxPackage -package $PackageFullName
    }
    else
    {
        Write-Host "Unable to find package: $App"
    }
    if ($ProPackageFullName)
    {
        Write-Host "Removing Provisioned Package: $ProPackageFullName"
        Remove-AppxProvisionedPackage -online -packagename $ProPackageFullName
    }
    else
    {
        Write-Host "Unable to find provisioned package: $App"
    }
}
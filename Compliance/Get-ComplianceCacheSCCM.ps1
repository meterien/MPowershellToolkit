$ErrorActionPreference = "SilentlyContinue"  
$size = 10240
$CCM = New-Object -com UIResource.UIResourceMGR
($ccm.GetCacheInfo()).totalsize

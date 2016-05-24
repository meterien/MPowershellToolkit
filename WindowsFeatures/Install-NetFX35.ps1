$currentLocation = Split-Path -Parent $MyInvocation.MyCommand.Path;
Enable-WindowsOptionalFeature -Online -FeatureName NetFx3 -Source $currentLocation -LimitAccess -All
$racc = Get-ChildItem "$env:PUBLIC\Desktop" | Where-Object -Property "Name" -EQ "Redémarrer.lnk"
if($racc.Length -gt 0)
{
    return 'Compliant'
}
else
{
    return 'NonCompliant'
}
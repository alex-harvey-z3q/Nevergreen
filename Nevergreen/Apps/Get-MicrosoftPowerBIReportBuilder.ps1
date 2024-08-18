$Version = Get-Version -Uri 'https://www.microsoft.com/en-us/download/details.aspx?id=105942' -Pattern 'Version:<.+?>((?:\d+\.)+\d+)' #'Version:\s+</div><p>((?:\d+\.)+\d+)'
$URL32 = Get-Link -Uri 'https://www.microsoft.com/en-us/download/confirmation.aspx?id=105942' -MatchProperty href -Pattern '\.msi$'

New-NevergreenApp -Name 'Microsoft Power BI Report Builder' -Version $Version -Uri $URL32 -Architecture 'x86' -Type 'Msi'

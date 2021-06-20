$URL32 = Get-Link -Uri 'https://www.advanced-port-scanner.com' -MatchProperty href -Pattern 'Advanced_Port_Scanner.+\.exe'
$Version = $URL32 | Get-Version

New-NevergreenApp -Version $Version -Uri $URL32 -Architecture 'x86'
$Version = Get-Version -Uri 'https://www.radiodetection.com/en-gb/resources/software-downloads/cat4-manager' -Pattern 'Version: ((?:\d+\.)+\d+)'

$URL32 = Get-Link -Uri 'https://www.radiodetection.com/en-gb/resources/software-downloads/cat4-manager' -MatchProperty href -Pattern '\.zip'

New-NevergreenApp -Version $Version -Uri $URL32 -Architecture 'x86'
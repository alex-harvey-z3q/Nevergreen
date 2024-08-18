$URL32,$URL64,$URLARM64 = Get-Link -Uri 'https://helpx.adobe.com/uk/download-install/kb/creative-cloud-desktop-app-download.html' -MatchProperty href -Pattern 'win32','win64','winarm64' -Headers @{'accept' = '*/*'; 'accept-language' = 'en-GB,en;q=0.9,en-US;q=0.8'}

$Version32,$Version64,$VersionARM64 = $URL32,$URL64,$URLARM64 | Get-Version -Pattern '((?:\d+\.)+\d+)(?!.+(?:\d+\.)+\d+)' -ReplaceWithDot

New-NevergreenApp -Name 'Adobe Creative Cloud' -Version $Version32 -Uri $URL32 -Architecture 'x86' -Type 'Zip'
New-NevergreenApp -Name 'Adobe Creative Cloud' -Version $Version64 -Uri $URL64 -Architecture 'x64' -Type 'Zip'
New-NevergreenApp -Name 'Adobe Creative Cloud' -Version $VersionARM64 -Uri $URLARM64 -Architecture 'ARM64' -Type 'Zip'
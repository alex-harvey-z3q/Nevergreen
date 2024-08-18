$Response = Invoke-WebRequest -Uri 'https://www.microsoft.com/en-us/download/details.aspx?id=53018' -DisableKeepAlive -UseBasicParsing

$Version = $Response.Content | Get-Version -Pattern '"version":"((?:\d+\.)+\d+)'
$URLMsi = $Response.Content | Get-Version -Pattern '"(https://[^"]*\.msi)'
$URLExe = $Response.Content | Get-Version -Pattern '"(https://[^"]*\.exe)'

New-NevergreenApp -Name 'Microsoft Purview Information Protection' -Version $Version -Uri $URLMsi -Architecture 'x86' -Type 'MSI'
New-NevergreenApp -Name 'Microsoft Purview Information Protection' -Version $Version -Uri $URLExe -Architecture 'x86' -Type 'Exe'
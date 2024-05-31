try {
    $Content = (Invoke-RestMethod -Uri 'https://support-portal.8x8.com/helpcenter/docrenderservice/services/rest/documents/8bff4970-6fbf-4daf-842d-8ae9b533153d?mandatorKey=MANDATOR_USU&contentLanguage=en&additionalData=references=true&additionalData=referencedDocs=true&additionalData=withGraph=true&additionalData=includeReferencesUpToLevel=all' -DisableKeepAlive).Content

    $MsiUrl = ($Content | Select-String -Pattern 'https://[^<]+\.msi').Matches.Value | Select-Object -First 1
    $ExeUrl = ($Content | Select-String -Pattern 'https://[^<]+\.exe').Matches.Value | Select-Object -First 1
    $Version = $URL | Get-Version -ReplaceWithDot

    New-NevergreenApp -Name '8x8 Work' -Version $Version -Uri $MsiUrl -Architecture 'x64' -Type 'MSI'
    New-NevergreenApp -Name '8x8 Work' -Version $Version -Uri $ExeUrl -Architecture 'x64' -Type 'Exe'
}
catch {
    Write-Error "$($MyInvocation.MyCommand): $($_.Exception.Message)"
}
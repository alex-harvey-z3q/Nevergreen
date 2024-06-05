$Apps = @(
    @{Name = '8x8 Work'; Architecture = 'x64'; Type = 'Exe'; Pattern = 'https://[^<]+\.exe' }
    @{Name = '8x8 Work'; Architecture = 'x64'; Type = 'MSI'; Pattern = 'https://[^<]+\.msi' }
)

try {
    # Download page https://support-portal.8x8.com/viewArticle.html?d=8bff4970-6fbf-4daf-842d-8ae9b533153d&hl=en references content below
    $Content = (Invoke-RestMethod -Uri 'https://support-portal.8x8.com/helpcenter/docrenderservice/services/rest/documents/8bff4970-6fbf-4daf-842d-8ae9b533153d?mandatorKey=MANDATOR_USU&contentLanguage=en&additionalData=references=true&additionalData=referencedDocs=true&additionalData=withGraph=true&additionalData=includeReferencesUpToLevel=all' -DisableKeepAlive).Content

    foreach ($App in $Apps) {
        $Url = ($Content | Select-String -Pattern $App.Pattern).Matches.Value | Select-Object -First 1
        $Version = $Url | Get-Version -ReplaceWithDot
        New-NevergreenApp -Name $App.Name -Version $Version -Uri $Url -Architecture $App.Architecture -Type $App.Type
    }

}
catch {
    Write-Error "$($MyInvocation.MyCommand): $($_.Exception.Message)"
}
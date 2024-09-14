$AppName = "HL7Spy"

$Arch = "x64" # Apparently the only supported one.
$ReleaseUrl = "https://hl7spy.ca/blog/"
$ReleaseNotesUrl = "https://hl7spy.ca/release-history/" # N.B. This does not always appear to be kept upto date.
$InstallInstructionsUrl = "https://conevity.atlassian.net/wiki/spaces/HL7Spy4/pages/626065447/Download+Installation"

Write-Verbose "Obtaining $($AppName) Release Versions from $($ReleaseUrl)...`n"

$AppVersions = @(
    @{AppName = "$($AppName)"; Type = 'exe'; URLPattern = 'HL7Spy\.(\d+\.\d+(\.\d+))'}
)

foreach ($AppVersion in $AppVersions) {

    # Get all matching URLs
    $URLs = Get-Link -Uri $ReleaseUrl -MatchProperty href -Pattern $AppVersion.URLPattern |
            Set-UriPrefix -Prefix 'https://hl7spy.ca/'

    # If no URLs found, write a warning and continue
    if (-not $URLs) {
        Write-Warning "Could not find release for $($AppVersion.AppName) $($AppVersion.Type)"
        continue
    }

    # Get versions from URLs
    $VersionUrlPairs = @()
    foreach ($Url in $URLs) {
        $VerString = Get-Version -String $Url

        # Parse the version string as a SemVer
        try {
            $SemVer   = Parse-SemVer -VersionString $VerString
            $IsStable = $true  # Assuming no pre-release versions appear.

            $VersionUrlPairs += [PSCustomObject]@{
                Version  = $SemVer
                Url      = $Url
                IsStable = $IsStable
            }
        } catch {
            Write-Warning "Invalid version format '$VerString' for URL '$Url'"
        }
    }

    # If no valid versions found, write a warning and continue
    if (-not $VersionUrlPairs) {
        Write-Warning "Could not extract valid versions for $($AppVersion.AppName) $($AppVersion.Type)"
        continue
    }

    # Sort versions descending
    $HighestVersionPair = $VersionUrlPairs | Sort-Object -Descending -Property `
        @{ Expression = { $_.Version.Major } }, `
        @{ Expression = { $_.Version.Minor } }, `
        @{ Expression = { $_.Version.Patch } }, `
        @{ Expression = { $_.IsStable } } | `
        Select-Object -First 1

    # Construct the version string
    $VersionString = "$($HighestVersionPair.Version.Major)." +
                     "$($HighestVersionPair.Version.Minor)." +
                     "$($HighestVersionPair.Version.Patch)" +
                     ($HighestVersionPair.Version.PreRelease ? "-$($HighestVersionPair.Version.PreRelease)" : '')

    # Create the app with the highest version
    New-NevergreenApp -Name $($AppVersion.AppName) `
                      -Architecture $Arch `
                      -Version $VersionString `
                      -Uri $($HighestVersionPair.Url) `
                      -Type $($AppVersion.Type)
}

Write-Verbose ""
Write-Verbose "$($AppName) Install instructions are available here: $($InstallInstructionsUrl)"
Write-Verbose "$($AppName) (Version: $($Version)) Release notes are available here: $($ReleaseNotesUrl)"

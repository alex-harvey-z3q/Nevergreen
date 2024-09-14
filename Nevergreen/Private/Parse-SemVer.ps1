function Parse-SemVer {
    <#
    .SYNOPSIS
    Parses a Semantic Versioning (SemVer) string into its components.

    .DESCRIPTION
    The `Parse-SemVer` function takes a version string that follows the Semantic Versioning format
    (e.g., '1.2.3', '1.2.3-alpha') and parses it into its constituent parts: Major, Minor, Patch,
    and PreRelease.

    .PARAMETER VersionString
    The version string to parse. It should follow the SemVer format:
    Major.Minor.Patch[-PreRelease]

    .OUTPUTS
    PSCustomObject
    An object containing the following properties:
    - Major (int): The major version number.
    - Minor (int): The minor version number.
    - Patch (int): The patch version number.
    - PreRelease (string): The pre-release identifier, if any.

    .EXAMPLE
    $SemVer = Parse-SemVer -VersionString '1.2.3'
    $SemVer

    This will output:
    ```
    Major      : 1
    Minor      : 2
    Patch      : 3
    PreRelease :
    ```

    .EXAMPLE
    $SemVer = Parse-SemVer -VersionString '2.5.0-beta'
    $SemVer

    This will output:
    ```
    Major      : 2
    Minor      : 5
    Patch      : 0
    PreRelease : beta
    ```

    .NOTES
    - The function uses a regular expression to parse the version string.
    - If the version string does not match the expected SemVer pattern, the function will throw an error.

    .LINK
    https://semver.org

    #>

    param (
        [string]$VersionString
    )

    $Pattern = '^(\d+)\.(\d+)\.(\d+)(?:-(.+))?$'
    $Match = [regex]::Match($VersionString, $Pattern)

    if ($Match.Success) {
        return [PSCustomObject]@{
            Major      = [int]$Match.Groups[1].Value
            Minor      = [int]$Match.Groups[2].Value
            Patch      = [int]$Match.Groups[3].Value
            PreRelease = $Match.Groups[4].Value
        }
    } else {
        throw "Invalid SemVer string: $VersionString"
    }
}

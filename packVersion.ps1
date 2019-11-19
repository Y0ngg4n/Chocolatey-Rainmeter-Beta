$version = '4.4.0.3333'
$releaseVersion = '4.4-r3333'

$checksumUrl = "https://github.com/rainmeter/rainmeter/releases/download/v${version}/Rainmeter-${releaseVersion}-beta.exe"
$checksum64Url = "https://github.com/rainmeter/rainmeter/releases/download/v${version}/Rainmeter-${releaseVersion}-beta.exe"

Invoke-RestMethod -Method Get -Uri $checksumUrl -OutFile "rainmeter.exe"

Invoke-RestMethod -Method Get -Uri $checksum64Url -OutFile "rainmeter64.exe"

$checksum   = (Get-FileHash -Path "rainmeter.exe" -Algorithm SHA256).Hash

$checksum64 = (Get-FileHash -Path "rainmeter64.exe" -Algorithm SHA256).Hash

Write-Host $checksum
Write-Host $checksum64

(Get-Content tools/chocolateyinstall.ps1) `
    -replace '#REPLACE_VERSION#', $version `
    -replace '#REPLACE_BETA_VERSION#', $releaseVersion |
  Out-File tools/chocolateyinstall.ps1

(Get-Content tools/chocolateyinstall.ps1) `
    -replace '#REPLACE_CHECKSUM#', $checksum `
    -replace '#REPLACE_CHECKSUM_64#', $checksum64 |
  Out-File tools/chocolateyinstall.ps1

(Get-Content rainmeter-beta.nuspec) `
    -replace '#REPLACE_VERSION#', $version |
Out-File rainmeter-beta.nuspec

choco pack

(Get-Content tools/chocolateyinstall.ps1) `
    -replace $version, '#REPLACE_VERSION#' `
    -replace $releaseVersion, '#REPLACE_BETA_VERSION# |
  Out-File tools/chocolateyinstall.ps1

(Get-Content tools/chocolateyinstall.ps1) `
    -replace $checksum, '#REPLACE_CHECKSUM#' `
    -replace $checksum64, '#REPLACE_CHECKSUM_64#' |
  Out-File tools/chocolateyinstall.ps1

(Get-Content rainmeter-beta.nuspec) `
    -replace $version, '#REPLACE_VERSION#' |
Out-File rainmeter-beta.nuspec
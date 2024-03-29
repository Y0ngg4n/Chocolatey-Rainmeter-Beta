$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$version = '#REPLACE_VERSION#'
$releaseVersion = '#REPLACE_BETA_VERSION#'

$checksum   = "#REPLACE_CHECKSUM#"
$checksum64 = "#REPLACE_CHECKSUM#"

Write-Output "Checksums for Version $version"
Write-Output "$checksum"
Write-Output "$checksum64"

$url        = "https://github.com/rainmeter/rainmeter/releases/download/v$version/Rainmeter-$releaseVersion-beta.exe"
$url64      = "https://github.com/rainmeter/rainmeter/releases/download/v$version/Rainmeter-$releaseVersion-beta.exe"

$pp = Get-PackageParameters

$ahkFile = "$toolsDir\button.ahk"

Start-Process 'AutoHotkey' $ahkFile

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  silentArgs     = '/S' + $pp

  softwareName  = 'rainmeter*'

  checksum      = $checksum
  checksumType  = 'sha256'
  checksum64    = $checksum64
  checksumType64= 'sha256'

  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

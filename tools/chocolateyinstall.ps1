$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$version = '4.4.0.3333'
$releaseVersion '4.4-r3333'

$checksum   = "E783F4146DF6D12363B4FE2825BA3A7E75DD3A2172AB111B0A654B8E3897884A"
$checksum64 = "E783F4146DF6D12363B4FE2825BA3A7E75DD3A2172AB111B0A654B8E3897884A"

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

[CmdletBinding()]
param([string]$Destination=(Join-Path $env:USERPROFILE '.codex\skills\local-file-organizer'))
$ErrorActionPreference='Stop'
$source=Join-Path $PSScriptRoot 'local-file-organizer'
if(-not(Test-Path -LiteralPath (Join-Path $source 'SKILL.md'))){throw 'Skill source is incomplete.'}
New-Item -ItemType Directory -Path $Destination -Force|Out-Null
Copy-Item -Path (Join-Path $source '*') -Destination $Destination -Recurse -Force
Write-Host "Installed local-file-organizer to $Destination"

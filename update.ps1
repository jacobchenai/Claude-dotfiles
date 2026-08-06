# Pull the latest dotfiles and copy skills + tools into ~/.claude (Windows).
# Windows Git Bash can't make real symlinks, so this repo installs by copy.
# Re-run any time you push updates from another machine. Safe to re-run.
#
# Usage:  ./update.ps1
#         ./update.ps1 -SkipPull   # copy only, don't git pull

param([switch]$SkipPull)

$ErrorActionPreference = 'Stop'

$repo      = $PSScriptRoot
$claudeDir = if ($env:CLAUDE_HOME) { $env:CLAUDE_HOME } else { Join-Path $HOME '.claude' }
$skillsDst = Join-Path $claudeDir 'skills'

if (-not $SkipPull) {
    Write-Host "Pulling latest from origin..."
    git -C $repo pull
}

New-Item -ItemType Directory -Force -Path $skillsDst | Out-Null

# Merge skills into ~/.claude/skills (leaves skills the repo doesn't manage in place)
Copy-Item -Path (Join-Path $repo 'skills\*') -Destination $skillsDst -Recurse -Force

# Copy the tools registry to ~/.claude/tools
Copy-Item -Path (Join-Path $repo 'tools') -Destination $claudeDir -Recurse -Force

$skillCount = (Get-ChildItem -Path $skillsDst -Recurse -Depth 1 -Filter 'SKILL.md').Count
$registry   = Test-Path (Join-Path $claudeDir 'tools\REGISTRY.md')
Write-Host "Done. $skillCount skills in $skillsDst; tools REGISTRY present: $registry"

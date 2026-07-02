[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$CodexSkillsRoot = (Join-Path $HOME '.codex\skills'),
    [string]$AgentsSkillsRoot = (Join-Path $HOME '.agents\skills'),
    [switch]$Force
)

$ErrorActionPreference = 'Stop'
$repoRoot = $PSScriptRoot

$skills = @(
    @{ Name = 'grill-me'; Root = $AgentsSkillsRoot }
    @{ Name = 'guide-me'; Root = $CodexSkillsRoot }
    @{ Name = 'orchestrate'; Root = $CodexSkillsRoot }
    @{ Name = 'teach'; Root = $CodexSkillsRoot }
    @{ Name = 'writing-great-skills'; Root = $CodexSkillsRoot }
)

function Get-TreeFingerprint {
    param([string]$Root)

    $absoluteRoot = [System.IO.Path]::GetFullPath($Root).TrimEnd('\', '/')

    Get-ChildItem -Recurse -File -LiteralPath $absoluteRoot |
        ForEach-Object {
            $relativePath = $_.FullName.Substring($absoluteRoot.Length).TrimStart([char[]]'\/')
            "$relativePath|$((Get-FileHash -Algorithm SHA256 -LiteralPath $_.FullName).Hash)"
        } |
        Sort-Object
}

function Test-TreesEqual {
    param(
        [string]$Source,
        [string]$Target
    )

    if (-not (Test-Path -LiteralPath $Target -PathType Container)) {
        return $false
    }

    $difference = Compare-Object (Get-TreeFingerprint $Source) (Get-TreeFingerprint $Target)
    return $null -eq $difference
}

function Assert-SafeTarget {
    param(
        [string]$Root,
        [string]$Target
    )

    $absoluteRoot = [System.IO.Path]::GetFullPath($Root).TrimEnd('\', '/')
    $absoluteTarget = [System.IO.Path]::GetFullPath($Target)
    $expectedPrefix = "$absoluteRoot$([System.IO.Path]::DirectorySeparatorChar)"

    if (-not $absoluteTarget.StartsWith($expectedPrefix, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Unsafe target outside installation root: $absoluteTarget"
    }
}

foreach ($skill in $skills) {
    $source = Join-Path (Join-Path $repoRoot 'skills') $skill.Name
    $targetRoot = [System.IO.Path]::GetFullPath($skill.Root)
    $target = Join-Path $targetRoot $skill.Name

    if (-not (Test-Path -LiteralPath $source -PathType Container)) {
        throw "Canonical skill is missing: $source"
    }

    Assert-SafeTarget -Root $targetRoot -Target $target

    if (Test-TreesEqual -Source $source -Target $target) {
        Write-Output "Up to date: $($skill.Name)"
        continue
    }

    if ((Test-Path -LiteralPath $target) -and -not $Force) {
        throw "Installed skill differs from the repository: $target. Re-run with -Force to replace it."
    }

    if ($PSCmdlet.ShouldProcess($target, "Install canonical skill $($skill.Name)")) {
        New-Item -ItemType Directory -Force -Path $targetRoot | Out-Null

        if (Test-Path -LiteralPath $target) {
            Remove-Item -Recurse -Force -LiteralPath $target
        }

        Copy-Item -Recurse -LiteralPath $source -Destination $target
        Write-Output "Installed: $($skill.Name) -> $target"
    }
}

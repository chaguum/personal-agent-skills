[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$CodexSkillsRoot = (Join-Path $HOME '.codex\skills'),
    [Alias('AgentsSkillsRoot')]
    [string]$CopilotSkillsRoot = (Join-Path $HOME '.agents\skills'),
    [switch]$Force
)

$ErrorActionPreference = 'Stop'
$repoRoot = $PSScriptRoot

$skillNames = @(
    'bootstrap-me'
    'grill-me'
    'guide-me'
    'orchestrate'
    'teach'
    'writing-great-skills'
)

$harnesses = @(
    @{ Name = 'codex'; SourceRoot = (Join-Path $repoRoot 'codex\skills'); TargetRoot = $CodexSkillsRoot }
    @{ Name = 'copilot'; SourceRoot = (Join-Path $repoRoot 'copilot\skills'); TargetRoot = $CopilotSkillsRoot }
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

foreach ($harness in $harnesses) {
    foreach ($skillName in $skillNames) {
        $source = Join-Path $harness.SourceRoot $skillName
        $targetRoot = [System.IO.Path]::GetFullPath($harness.TargetRoot)
        $target = Join-Path $targetRoot $skillName

        if (-not (Test-Path -LiteralPath $source -PathType Container)) {
            throw "Canonical $($harness.Name) skill is missing: $source"
        }

        Assert-SafeTarget -Root $targetRoot -Target $target

        if (Test-TreesEqual -Source $source -Target $target) {
            Write-Output "Up to date: $($harness.Name)/$skillName"
            continue
        }

        if ((Test-Path -LiteralPath $target) -and -not $Force) {
            throw "Installed skill differs from the repository: $target. Re-run with -Force to replace it."
        }

        if ($PSCmdlet.ShouldProcess($target, "Install canonical $($harness.Name) skill $skillName")) {
            New-Item -ItemType Directory -Force -Path $targetRoot | Out-Null

            if (Test-Path -LiteralPath $target) {
                Remove-Item -Recurse -Force -LiteralPath $target
            }

            Copy-Item -Recurse -LiteralPath $source -Destination $target
            Write-Output "Installed: $($harness.Name)/$skillName -> $target"
        }
    }
}

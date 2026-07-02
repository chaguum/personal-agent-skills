$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$installer = Join-Path $repoRoot 'install.ps1'
$sandbox = Join-Path ([System.IO.Path]::GetTempPath()) "personal-agent-skills-$([guid]::NewGuid())"
$codexRoot = Join-Path $sandbox '.codex\skills'
$agentsRoot = Join-Path $sandbox '.agents\skills'

function Assert-True {
    param(
        [bool]$Condition,
        [string]$Message
    )

    if (-not $Condition) {
        throw "Assertion failed: $Message"
    }
}

try {
    & $installer -CodexSkillsRoot $codexRoot -AgentsSkillsRoot $agentsRoot

    Assert-True (Test-Path (Join-Path $agentsRoot 'grill-me\SKILL.md')) 'grill-me must install under the agents root'
    Assert-True (Test-Path (Join-Path $codexRoot 'guide-me\SKILL.md')) 'guide-me must install under the Codex root'
    Assert-True (Test-Path (Join-Path $codexRoot 'orchestrate\session-review.md')) 'orchestrate must install with its review protocol'
    Assert-True (Test-Path (Join-Path $codexRoot 'teach\SKILL.md')) 'teach must install under the Codex root'
    Assert-True (Test-Path (Join-Path $codexRoot 'writing-great-skills\GLOSSARY.md')) 'writing-great-skills must include its glossary'

    & $installer -CodexSkillsRoot $codexRoot -AgentsSkillsRoot $agentsRoot

    $guideTarget = Join-Path $codexRoot 'guide-me\SKILL.md'
    Add-Content -LiteralPath $guideTarget -Value "`nlocal divergence"

    $blocked = $false
    try {
        & $installer -CodexSkillsRoot $codexRoot -AgentsSkillsRoot $agentsRoot
    }
    catch {
        $blocked = $true
    }
    Assert-True $blocked 'a divergent installed skill must not be overwritten without -Force'

    & $installer -CodexSkillsRoot $codexRoot -AgentsSkillsRoot $agentsRoot -Force
    $sourceGuide = Get-Content -Raw -LiteralPath (Join-Path $repoRoot 'skills\guide-me\SKILL.md')
    $installedGuide = Get-Content -Raw -LiteralPath $guideTarget
    Assert-True ($sourceGuide -ceq $installedGuide) '-Force must restore the canonical repository version'

    Write-Output 'All installer tests passed.'
}
finally {
    if (Test-Path -LiteralPath $sandbox) {
        Remove-Item -Recurse -Force -LiteralPath $sandbox
    }
}

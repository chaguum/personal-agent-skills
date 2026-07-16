$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$installer = Join-Path $repoRoot 'install.ps1'
$sandbox = Join-Path ([System.IO.Path]::GetTempPath()) "personal-agent-skills-$([guid]::NewGuid())"
$codexRoot = Join-Path $sandbox '.codex\skills'
$copilotRoot = Join-Path $sandbox '.agents\skills'
$sharedSkillNames = @('bootstrap-me', 'grill-me', 'guide-me', 'orchestrate', 'teach', 'writing-great-skills')
$codexSkillNames = $sharedSkillNames + @('tune-me', 'create-thread')
$copilotSkillNames = $sharedSkillNames

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
    & $installer -CodexSkillsRoot $codexRoot -CopilotSkillsRoot $copilotRoot

    foreach ($skillName in $codexSkillNames) {
        Assert-True (Test-Path (Join-Path $codexRoot "$skillName\SKILL.md")) "$skillName must install under the Codex root"
    }
    foreach ($skillName in $copilotSkillNames) {
        Assert-True (Test-Path (Join-Path $copilotRoot "$skillName\SKILL.md")) "$skillName must install under the Copilot root"
    }
    Assert-True (-not (Test-Path (Join-Path $copilotRoot 'tune-me'))) 'Codex-only tune-me must not install under the Copilot root'
    Assert-True (Test-Path (Join-Path $codexRoot 'orchestrate\agent-review.md')) 'Codex orchestrate must install its automatic agent review protocol'
    Assert-True (Test-Path (Join-Path $copilotRoot 'orchestrate\session-review.md')) 'Copilot orchestrate must retain its manual session review protocol'
    Assert-True (Test-Path (Join-Path $codexRoot 'writing-great-skills\GLOSSARY.md')) 'Codex writing-great-skills must include its glossary'
    Assert-True (Test-Path (Join-Path $copilotRoot 'writing-great-skills\GLOSSARY.md')) 'Copilot writing-great-skills must include its glossary'

    & $installer -CodexSkillsRoot $codexRoot -CopilotSkillsRoot $copilotRoot

    $guideTarget = Join-Path $codexRoot 'guide-me\SKILL.md'
    Add-Content -LiteralPath $guideTarget -Value "`nlocal divergence"

    $blocked = $false
    try {
        & $installer -CodexSkillsRoot $codexRoot -CopilotSkillsRoot $copilotRoot
    }
    catch {
        $blocked = $true
    }
    Assert-True $blocked 'a divergent installed skill must not be overwritten without -Force'

    & $installer -CodexSkillsRoot $codexRoot -CopilotSkillsRoot $copilotRoot -Force
    $sourceGuide = Get-Content -Raw -LiteralPath (Join-Path $repoRoot 'codex\skills\guide-me\SKILL.md')
    $installedGuide = Get-Content -Raw -LiteralPath $guideTarget
    Assert-True ($sourceGuide -ceq $installedGuide) '-Force must restore the canonical repository version'

    Write-Output 'All installer tests passed.'
}
finally {
    if (Test-Path -LiteralPath $sandbox) {
        Remove-Item -Recurse -Force -LiteralPath $sandbox
    }
}

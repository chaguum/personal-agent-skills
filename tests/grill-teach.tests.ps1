$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot

function Assert-Contains {
    param(
        [string]$Content,
        [string]$Pattern,
        [string]$Message
    )

    if ($Content -notmatch $Pattern) {
        throw "Assertion failed: $Message"
    }
}

foreach ($harness in @('codex', 'copilot')) {
    $root = Join-Path $repoRoot "$harness\skills"
    $grill = Get-Content -Raw -Encoding utf8 (Join-Path $root 'grill-me\SKILL.md')
    $writing = Get-Content -Raw -Encoding utf8 (Join-Path $root 'writing-great-skills\SKILL.md')
    $glossary = Get-Content -Raw -Encoding utf8 (Join-Path $root 'writing-great-skills\GLOSSARY.md')
    $teachConfig = Get-Content -Raw -Encoding utf8 (Join-Path $root 'teach\agents\openai.yaml')

    Assert-Contains $grill 'Travaille par \*\*rounds\*\*' "$harness grill-me must use rounds"
    Assert-Contains $grill 'fronti' "$harness grill-me must ask the current frontier in one round"
    Assert-Contains $writing '\*\*Negation\*\*' "$harness writing-great-skills must document negation"
    Assert-Contains $glossary '(?m)^### Negation' "$harness writing-great-skills glossary must define negation"
    Assert-Contains $teachConfig 'allow_implicit_invocation: false' "$harness teach must remain user-invoked"
}

Write-Output 'All grill-me and teach contract tests passed.'

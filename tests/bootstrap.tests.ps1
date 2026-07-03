$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot

foreach ($harness in @('codex', 'copilot')) {
    $root = Join-Path $repoRoot "$harness\skills\bootstrap-me"
    foreach ($relativePath in @('SKILL.md', 'agents\openai.yaml')) {
        if (-not (Test-Path -LiteralPath (Join-Path $root $relativePath) -PathType Leaf)) {
            throw "Missing $harness bootstrap-me file: $relativePath"
        }
    }

    $skill = Get-Content -Raw -Encoding utf8 (Join-Path $root 'SKILL.md')
    $config = Get-Content -Raw -Encoding utf8 (Join-Path $root 'agents\openai.yaml')

    foreach ($required in @('Use `grill-me`', 'AGENTS.md', 'architecture.md', 'decisions.md', 'PROGRESS.md', 'Definition of Done', 'commit')) {
        if (-not $skill.Contains($required)) {
            throw "Assertion failed: $harness bootstrap-me must contain '$required'"
        }
    }
    if (-not $skill.Contains('`orchestrate`') -or -not $skill.Contains('invoque explicitement')) {
        throw "Assertion failed: $harness bootstrap-me must stop at an explicit orchestrate handoff"
    }
    if (-not $config.Contains('allow_implicit_invocation: false')) {
        throw "Assertion failed: $harness bootstrap-me must be user-invoked"
    }
}

Write-Output 'All bootstrap-me contract tests passed.'

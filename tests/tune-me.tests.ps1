$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$skillRoot = Join-Path $repoRoot 'codex\skills\tune-me'
$skillFile = Join-Path $skillRoot 'SKILL.md'
$metadataFile = Join-Path $skillRoot 'agents\openai.yaml'

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

if (-not (Test-Path -LiteralPath $skillFile)) {
    throw 'Assertion failed: Codex tune-me SKILL.md must exist'
}
if (-not (Test-Path -LiteralPath $metadataFile)) {
    throw 'Assertion failed: Codex tune-me agents/openai.yaml must exist'
}

$skill = Get-Content -Raw -LiteralPath $skillFile
$metadata = Get-Content -Raw -LiteralPath $metadataFile

Assert-Contains $skill '(?m)^name:\s*tune-me$' 'skill name must be tune-me'
Assert-Contains $skill 'AGENTS\.md' 'server and verification commands must come from applicable AGENTS.md'
Assert-Contains $skill 'navigateur intégré' 'the integrated browser must be required'
Assert-Contains $skill 'aucun fallback' 'browser failure must stop without fallback'
Assert-Contains $skill 'URL locale comme lien cliquable' 'invocation must return the local application URL as a clickable link'
Assert-Contains $skill 'attendre que.*ouvre' 'the agent must wait for the user to open the application'
Assert-Contains $skill 'niveau 1' 'Level 1 micro-fixes must be supported'
Assert-Contains $skill 'niveau 2' 'light Level 2 behavior changes must be supported'
Assert-Contains $skill 'orchestrate' 'structural changes must offer explicit escalation'
Assert-Contains $skill 'Ne déclenche jamais.*orchestrate' 'orchestrate must never start automatically'
Assert-Contains $skill 'annotations' 'annotation feedback must be supported'
Assert-Contains $skill 'captures' 'screenshot feedback must be supported'
Assert-Contains $skill 'changements.*présents' 'pre-existing working-tree changes must be preserved'
Assert-Contains $skill 'commit' 'commits must be addressed explicitly'
Assert-Contains $metadata 'allow_implicit_invocation:\s*false' 'tune-me must require explicit invocation'
Assert-Contains $metadata '\$tune-me' 'default prompt must mention $tune-me'

Write-Output 'All tune-me contract tests passed.'

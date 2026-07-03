$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$codexOrchestrateRoot = Join-Path $repoRoot 'codex\skills\orchestrate'
$copilotOrchestrateRoot = Join-Path $repoRoot 'copilot\skills\orchestrate'
$codexGrillRoot = Join-Path $repoRoot 'codex\skills\grill-me'

function Assert-Contains {
    param(
        [string]$Text,
        [string]$Expected,
        [string]$Message
    )

    if (-not $Text.Contains($Expected)) {
        throw "Assertion failed: $Message"
    }
}

function Assert-NotContains {
    param(
        [string]$Text,
        [string]$Unexpected,
        [string]$Message
    )

    if ($Text.Contains($Unexpected)) {
        throw "Assertion failed: $Message"
    }
}

$requiredFiles = @(
    'SKILL.md',
    'direct-execution.md',
    'progress-template.md',
    'agent-mission-template.md',
    'agent-review.md',
    'agents\openai.yaml'
)

foreach ($relativePath in $requiredFiles) {
    $path = Join-Path $codexOrchestrateRoot $relativePath
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        throw "Missing Codex orchestrate file: $relativePath"
    }
}

$skill = Get-Content -Raw -Encoding utf8 (Join-Path $codexOrchestrateRoot 'SKILL.md')
$directExecution = Get-Content -Raw -Encoding utf8 (Join-Path $codexOrchestrateRoot 'direct-execution.md')
$progressTemplate = Get-Content -Raw -Encoding utf8 (Join-Path $codexOrchestrateRoot 'progress-template.md')
$missionTemplate = Get-Content -Raw -Encoding utf8 (Join-Path $codexOrchestrateRoot 'agent-mission-template.md')
$review = Get-Content -Raw -Encoding utf8 (Join-Path $codexOrchestrateRoot 'agent-review.md')
$orchestrateConfig = Get-Content -Raw -Encoding utf8 (Join-Path $codexOrchestrateRoot 'agents\openai.yaml')
$grill = Get-Content -Raw -Encoding utf8 (Join-Path $codexGrillRoot 'SKILL.md')
$grillConfig = Get-Content -Raw -Encoding utf8 (Join-Path $codexGrillRoot 'agents\openai.yaml')
$copilotSkill = Get-Content -Raw -Encoding utf8 (Join-Path $copilotOrchestrateRoot 'SKILL.md')
$codexText = $skill + $directExecution + $missionTemplate + $review + $progressTemplate

Assert-Contains $skill 'Use `grill-me`' 'orchestrate must require grill-me for initial planning'
Assert-Contains $skill 'AGENTS.md' 'orchestrate must read repository instructions first'
Assert-Contains $skill 'demande explicite de d' 'invoking Codex orchestrate must authorize agent delegation'
Assert-Contains $skill 'un seul agent de mission actif' 'Codex orchestrate must execute missions sequentially'
Assert-Contains $skill 'attends son r' 'Codex orchestrate must wait for the active agent'
Assert-NotContains $codexText 'session done' 'Codex orchestrate must not require a manual completion signal'
Assert-NotContains $codexText 'copier-coller' 'Codex orchestrate must not require manual prompt transfer'
Assert-NotContains $codexText 'session-prompt-template.md' 'Codex orchestrate must not reference the removed manual template'
Assert-Contains $skill 'direct-execution.md' 'orchestrate must disclose the direct execution branch conditionally'
Assert-Contains $skill 'attente utilisateur est explicite' 'orchestrate must define an observable routing completion criterion'
Assert-NotContains $skill 'confirmation explicite' 'direct execution approval must have a single source of truth'
Assert-Contains $directExecution 'une seule mission' 'direct execution must require a single mission'
Assert-Contains $directExecution 'confirmation explicite' 'direct execution must require explicit user approval'
Assert-Contains $directExecution 'PROGRESS.md' 'direct execution must persist its result'
Assert-Contains $directExecution 'commit' 'direct execution must create a validated checkpoint'
Assert-Contains $progressTemplate 'Mission active' 'the progress template must preserve resumable state'
Assert-Contains $progressTemplate 'Nombre de corrections' 'the progress template must track correction passes without a binary ceiling'
Assert-Contains $missionTemplate 'aucun commit' 'agents must leave commits to the orchestrator'
Assert-Contains $missionTemplate 'reprise synth' 'agents must keep PROGRESS.md compact'
Assert-Contains $missionTemplate 'retour final' 'detailed evidence must be returned to the orchestrator'
Assert-Contains $review 'replanification ou abandon' 'review must ask for arbitration after a failed corrective pass'
Assert-Contains $review 'envoyer au m' 'corrections must be routed back to the active agent'
Assert-Contains $review 'Definition of Done' 'review must apply the repository DoD'
Assert-Contains $orchestrateConfig 'allow_implicit_invocation: false' 'orchestrate must be user-invoked'
Assert-Contains $orchestrateConfig 'directement ou via des agents Codex' 'the UI description must expose both execution branches'
Assert-Contains $grillConfig 'allow_implicit_invocation: true' 'grill-me must be reachable by orchestrate'
Assert-Contains $copilotSkill 'session done' 'Copilot orchestrate must retain the manual session workflow'

if ($grill.Contains('## Découpage conseillé des sessions') -or $grill.Contains('## Prochaine action recommandée')) {
    throw 'grill-me still owns orchestration-specific output'
}

Write-Output 'All orchestrate contract tests passed.'

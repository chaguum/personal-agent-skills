$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$orchestrateRoot = Join-Path $repoRoot 'skills\orchestrate'
$grillRoot = Join-Path $repoRoot 'skills\grill-me'

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

$requiredFiles = @(
    'SKILL.md',
    'progress-template.md',
    'session-prompt-template.md',
    'session-review.md',
    'agents\openai.yaml'
)

foreach ($relativePath in $requiredFiles) {
    $path = Join-Path $orchestrateRoot $relativePath
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        throw "Missing orchestrate file: $relativePath"
    }
}

$skill = Get-Content -Raw -Encoding utf8 (Join-Path $orchestrateRoot 'SKILL.md')
$progressTemplate = Get-Content -Raw -Encoding utf8 (Join-Path $orchestrateRoot 'progress-template.md')
$promptTemplate = Get-Content -Raw -Encoding utf8 (Join-Path $orchestrateRoot 'session-prompt-template.md')
$review = Get-Content -Raw -Encoding utf8 (Join-Path $orchestrateRoot 'session-review.md')
$orchestrateConfig = Get-Content -Raw -Encoding utf8 (Join-Path $orchestrateRoot 'agents\openai.yaml')
$grill = Get-Content -Raw -Encoding utf8 (Join-Path $grillRoot 'SKILL.md')
$grillConfig = Get-Content -Raw -Encoding utf8 (Join-Path $grillRoot 'agents\openai.yaml')

Assert-Contains $skill 'Use `grill-me`' 'orchestrate must require grill-me for initial planning'
Assert-Contains $skill 'AGENTS.md' 'orchestrate must read repository instructions first'
Assert-Contains $skill 'session done' 'orchestrate must route completion signals'
Assert-Contains $skill 'uniquement le prochain prompt' 'orchestrate must generate one mission at a time'
Assert-Contains $progressTemplate 'Mission active' 'the progress template must preserve resumable state'
Assert-Contains $promptTemplate 'aucun commit' 'subsessions must leave commits to the orchestrator'
Assert-Contains $review 'seule correction' 'review must enforce the correction limit'
Assert-Contains $review 'Definition of Done' 'review must apply the repository DoD'
Assert-Contains $orchestrateConfig 'allow_implicit_invocation: false' 'orchestrate must be user-invoked'
Assert-Contains $grillConfig 'allow_implicit_invocation: true' 'grill-me must be reachable by orchestrate'

if ($grill.Contains('## Découpage conseillé des sessions') -or $grill.Contains('## Prochaine action recommandée')) {
    throw 'grill-me still owns orchestration-specific output'
}

Write-Output 'All orchestrate contract tests passed.'

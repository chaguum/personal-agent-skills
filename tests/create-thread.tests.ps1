$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$skillRoot = Join-Path $repoRoot 'codex\skills\create-thread'
$skillFile = Join-Path $skillRoot 'SKILL.md'
$metadataFile = Join-Path $skillRoot 'agents\openai.yaml'
$installer = Join-Path $repoRoot 'install.ps1'

function Assert-Contains {
    param([string]$Text, [string]$Pattern, [string]$Message)

    if ($Text -notmatch $Pattern) {
        throw "Assertion failed: $Message"
    }
}

function Assert-LiteralContains {
    param([string]$Text, [string]$Value, [string]$Message)

    if (-not $Text.Contains($Value)) {
        throw "Assertion failed: $Message"
    }
}

if (-not (Test-Path -LiteralPath $skillFile)) {
    throw 'Assertion failed: Codex create-thread SKILL.md must exist'
}

if (-not (Test-Path -LiteralPath $metadataFile)) {
    throw 'Assertion failed: Codex create-thread agents/openai.yaml must exist'
}

$skill = Get-Content -Raw -Encoding utf8 $skillFile
$metadata = Get-Content -Raw -Encoding utf8 $metadataFile
$installerText = Get-Content -Raw -Encoding utf8 $installer

Assert-Contains $skill '(?m)^name:\s*create-thread$' 'skill name must be create-thread'
Assert-Contains $skill 'codex_app__list_projects' 'creation must list projects first'
Assert-Contains $skill 'codex_app__create_thread' 'creation must use the Codex App create-thread tool'
Assert-Contains $skill 'codex_app__send_message_to_thread' 'continuation must use the Codex App send-message tool'
Assert-Contains $skill 'gpt-5\.6-luna' 'the exact Codex model identifier must be preserved'
Assert-Contains $skill 'thinking: "high"' 'the exact high reasoning value must be preserved'
Assert-LiteralContains $skill 'C:\\Users\\hugol\\Documents\\Courses & Recette' 'the exact Courses & Recette project identifier must be documented'
Assert-Contains $skill 'type: "worktree"' 'new threads must target a worktree'
Assert-Contains $skill 'created-thread' 'successful creation must emit a created-thread directive'
Assert-Contains $skill 'distinct detailed `prompt`' 'parallel tasks must have distinct prompts'
Assert-Contains $skill 'distinct `startingState.branchName`' 'parallel tasks must have distinct branches'
Assert-Contains $skill 'If a required tool is absent, stop' 'missing thread tools must be a hard blocker'
Assert-Contains $metadata 'allow_implicit_invocation:\s*false' 'thread creation must be user-invoked only'
Assert-Contains $installerText "'create-thread'" 'the Codex installer must include create-thread'

Write-Output 'create-thread skill contract passed.'

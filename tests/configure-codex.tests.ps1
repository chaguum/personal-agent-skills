$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$script = Join-Path $repoRoot 'configure-codex.ps1'
$sandbox = Join-Path ([System.IO.Path]::GetTempPath()) "configure-codex-$([guid]::NewGuid())"
$config = Join-Path $sandbox 'config.toml'
$agentsRoot = Join-Path $sandbox '.agents\skills'

try {
    New-Item -ItemType Directory -Force -Path $sandbox | Out-Null
    Set-Content -LiteralPath $config -Encoding utf8 -Value 'model = "test"'

    & $script -ConfigPath $config -AgentsSkillsRoot $agentsRoot
    & $script -ConfigPath $config -AgentsSkillsRoot $agentsRoot

    $text = Get-Content -Raw -Encoding utf8 $config
    foreach ($skillName in @('bootstrap-me', 'grill-me', 'guide-me', 'orchestrate', 'teach', 'writing-great-skills')) {
        $path = Join-Path $agentsRoot "$skillName\SKILL.md"
        if (([regex]::Matches($text, [regex]::Escape($path))).Count -ne 1) {
            throw "Assertion failed: $skillName must be disabled exactly once"
        }
    }
}
finally {
    if (Test-Path -LiteralPath $sandbox) {
        Remove-Item -Recurse -Force -LiteralPath $sandbox
    }
}

Write-Output 'All Codex configuration tests passed.'

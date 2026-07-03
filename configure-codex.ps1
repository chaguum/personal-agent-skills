[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$ConfigPath = (Join-Path $HOME '.codex\config.toml'),
    [string]$AgentsSkillsRoot = (Join-Path $HOME '.agents\skills')
)

$ErrorActionPreference = 'Stop'
$skillNames = @('bootstrap-me', 'grill-me', 'guide-me', 'orchestrate', 'teach', 'writing-great-skills')
$configDirectory = Split-Path -Parent $ConfigPath

if (-not (Test-Path -LiteralPath $configDirectory)) {
    New-Item -ItemType Directory -Force -Path $configDirectory | Out-Null
}

$content = if (Test-Path -LiteralPath $ConfigPath) {
    Get-Content -Raw -Encoding utf8 -LiteralPath $ConfigPath
}
else {
    ''
}

$blocks = foreach ($skillName in $skillNames) {
    $skillPath = Join-Path $AgentsSkillsRoot "$skillName\SKILL.md"
    if (-not $content.Contains($skillPath)) {
        "[[skills.config]]`npath = '$skillPath'`nenabled = false"
    }
}

if ($blocks.Count -gt 0) {
    $separator = if ([string]::IsNullOrWhiteSpace($content)) { '' } else { "`n`n" }
    $updated = $content.TrimEnd() + $separator + ($blocks -join "`n`n") + "`n"
    if ($PSCmdlet.ShouldProcess($ConfigPath, 'Disable duplicate Copilot skills in Codex')) {
        Set-Content -LiteralPath $ConfigPath -Encoding utf8 -Value $updated
    }
}

Write-Output 'Codex is configured to hide canonical Copilot skill copies.'

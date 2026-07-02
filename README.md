# Personal Agent Skills

Canonical repository for personal Codex and agent skills.

## Skills

| Skill | Installation target |
| --- | --- |
| `grill-me` | `~/.agents/skills/grill-me` |
| `guide-me` | `~/.codex/skills/guide-me` |
| `orchestrate` | `~/.codex/skills/orchestrate` |
| `teach` | `~/.codex/skills/teach` |
| `writing-great-skills` | `~/.codex/skills/writing-great-skills` |

`writing-great-skills` is adapted for Codex from [mattpocock/skills](https://github.com/mattpocock/skills/tree/main/skills/productivity/writing-great-skills).

## Source-of-truth workflow

Edit skills only under `skills/`, commit the changes, then install them:

```powershell
.\install.ps1 -Force
```

Without `-Force`, the installer refuses to overwrite an installed skill that differs from the repository. Re-running it when everything is synchronized is safe.

Preview filesystem changes with:

```powershell
.\install.ps1 -WhatIf
```

## Verification

Run the installer contract tests:

```powershell
.\tests\install.tests.ps1
```

The tests use temporary directories and do not modify the installed skills.

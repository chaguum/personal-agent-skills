# Personal Agent Skills

Canonical repository for personal Codex and GitHub Copilot skills.

## Harnesses

Each harness owns an independent copy of every skill:

| Canonical source | Installation target |
| --- | --- |
| `codex/skills/*` | `~/.codex/skills/*` |
| `copilot/skills/*` | `~/.agents/skills/*` |

The two trees start from the same skill inventory but may diverge when their
harness capabilities require different workflows. Edit the harness-specific
copy only; do not assume a change applies to both.

Current skills shared by both trees:

- `bootstrap-me`
- `grill-me`
- `guide-me`
- `orchestrate`
- `teach`
- `writing-great-skills`

Codex-only skills:

- `tune-me`
- `create-thread`

`writing-great-skills` is adapted for Codex from [mattpocock/skills](https://github.com/mattpocock/skills/tree/main/skills/productivity/writing-great-skills).

## Source-of-truth workflow

Edit skills under the relevant harness directory, commit the changes, then
install both trees:

```powershell
.\install.ps1 -Force
```

Without `-Force`, the installer refuses to overwrite an installed skill that differs from the repository. Re-running it when everything is synchronized is safe.

Codex also discovers `$HOME/.agents/skills`. Keep the Copilot installations
while hiding their duplicate entries from Codex with:

```powershell
.\configure-codex.ps1
```

Restart Codex after changing its configuration.

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

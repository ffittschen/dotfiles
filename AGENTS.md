# AGENTS.md

## Overview

Chezmoi dotfiles repo. Source files here deploy to `~/`.

## Commands

```bash
chezmoi diff              # Preview pending changes
chezmoi apply -n -v       # Dry-run
chezmoi apply             # Apply to ~/
chezmoi re-add <file>     # Sync actual → source (plain files only, NOT .tmpl)
```

## Template Data

Defined in `.chezmoi.yaml.tmpl`:

- `.work` / `.personal` — machine type booleans (with corresponding `.work_vault` / `.personal_vault` 1Password vault IDs)
- `.headless` / `.ephemeral` — CI/VM/container environments

## Key Conventions

- Templates (`.tmpl`) cannot use `chezmoi re-add` — edit source directly.
- `modify_` prefix = script receiving current file on stdin, outputting merged result (used by `dot_claude/modify_settings.json` to preserve machine-local hooks/permissions).
- Git config at `private_dot_config/git/config.tmpl` uses `onepasswordDetailsFields` for email.
- Work-only configs are excluded via `.chezmoiignore` and managed manually.

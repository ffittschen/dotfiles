---
description: Prefer modern CLI tools over builtins for faster and less error-prone shell commands
alwaysApply: true
---

Prefer: `rg` over `grep`, `fd` over `find`, `ast-grep` for structural code search, `jq`/`xq` for JSON/XML, `difft` for diffs, `tokei` over `cloc`, `gdu` over `du`.

For built-in help, prefer `<toolname> help <command>` over `<toolname> <command> --help` when the tool supports it (e.g. `acli help workitem`, `gh help pr`, `git help log`). The subcommand form keeps the help verb in a stable leading position, which lets a single allowlist entry like `Bash(acli help:*)` cover every help invocation instead of needing one entry per `<command> --help` variant.

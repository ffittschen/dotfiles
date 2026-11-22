# Worktree-isolated sessions

A session entered through `EnterWorktree` or `claude --worktree` is isolated, and so is every subagent it spawns. In these sessions Claude Code refuses any Bash command whose git use it can't verify from the text, and no setting turns this off. Each refusal costs a rewrite, and they pile up fast. Write commands it can verify on the first try:

- `git` anywhere in a command with heredocs, chains, pipes or substitutions can trip it, even as data such as a heredoc body or an `rg` pattern. Run git as its own plain command. Put scripts and data in a file with the Write tool, then run the file.
- Paths only known at runtime trip it: `$VAR`, `$(...)`, `-C "$dir"`, `cd` into a computed directory. Spell paths out literally.
- Write and Edit follow symlinks. In a worktree `.agent-config/local` points into the main checkout, so writes through it are refused. Don't retry through another path; report what you would have written.

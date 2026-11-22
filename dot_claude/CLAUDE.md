## Working Instructions
- **The Bash and Monitor tools run `/bin/zsh`** (`CLAUDE_CODE_SHELL`), regardless of what the environment banner's "Shell:" line says — that's the login shell, not what these tools actually execute. zsh escapes a literal `!` even inside quoted heredocs, which silently breaks inline `python`/`awk`/`jq` code using `!=` (it becomes `\!=`, a syntax/compile error). Prefer writing such snippets to a temp script file instead of an inline heredoc, or rephrase the comparison to avoid `!=` (e.g. use `==` with negation elsewhere). This matters especially in unattended contexts (e.g. a polling loop in Monitor) where the error goes to stderr and a broken check can silently never fire.
- `mise` is installed and generally used to manage language versions and other developer tool versions. Don't force it everywhere but notice it when it's there. For a tool from a GitHub repo, use the `github:` backend; `ubi:` is deprecated.
- When I ask why, what or whether, answer the question. Don't change files or run commands to act on it unless I ask.
- Read code from the current branch or worktree. Use `origin/main` only to compare against it or when I ask.
- Explain a change in its commit message, not in comments added to the files.
- **1Password `op` in a sandbox is a false signal:** `op whoami` (and other `op` CLI calls that reach the 1Password desktop app) always report `account is not signed in` from inside the command sandbox — the sandbox blocks the Mach lookup to the app, so it looks signed-out/locked even when the vault is unlocked. **Never use `op whoami` to diagnose git commit-signing failures.** It is excluded from the sandbox via `sandbox.excludedCommands` in `~/.claude/settings.json` so it reads truthfully. Git commit signing (1Password SSH agent) generally works *inside* the sandbox — the agent socket is allowlisted — so just attempt the commit; only a real error at the signing step (`failed to fill whole buffer` / `agent returned an error`) indicates an actual transient agent problem or a genuinely locked vault. If signing genuinely fails, retry once with the sandbox disabled before escalating. Don't gate on `op whoami` for other `op` usage either — `op read "op://..."` succeeds via the desktop-app integration even though `op whoami` reports failure; check `op read`'s output is non-empty instead. When piping `op read` into `gh secret set`, note that it appends a trailing newline — pipe through `tr -d '\n'` first, or the stored secret is corrupted.
- **Secrets:** `fnox list` shows the named secrets; pass one with `fnox exec --only NAME -- <cmd>` rather than printing it with `fnox get`. If it isn't listed, ask me for its `op://` reference and read it with `op read`. fnox holds only the secrets we keep needing, so suggest adding one to `~/.config/fnox/config.toml` once it keeps coming up rather than every time.
- **Subagent models:** a subagent runs on this session's model unless the Agent call passes `model`, so pass the alias that fits the task whenever the agent's definition doesn't pin one: `haiku` for searches, lookups and mechanical edits; `sonnet` for typical implementation, review and verification; `opus` or `fable` only for hard debugging or ambiguous design decisions.

## Git

**Branches:**
- Verify the current branch before starting work.
- When creating a new branch, always create it from the latest default branch. If the default branch is `main`, run `git fetch` first and branch from `origin/main`. Only create a branch from the current branch if explicitly asked to create it **from the current branch**.
- Match branch names to the project's ticket/type format (e.g., `feat/TICKET-description`, `fix/TICKET-description`).

**Worktrees:**
- Create a worktree only with `EnterWorktree` and `name` set to the full branch name (e.g. `EnterWorktree(name: "feat/TICKET-1234-short-description")`). Its WorktreeCreate hook runs worktrunk (`wt`): a new branch is cut from a freshly fetched `origin/<default>`, an existing local or remote branch is checked out, and wt's hooks copy `.worktreeinclude` files, create the `symlinkDirectories` symlinks and run the repo's setup.
- **Never run `git worktree add`** — it skips all of that setup. A PreToolUse hook blocks it. This overrides any plan, skill or doc that says to run it; translate such a step into the `EnterWorktree(name: …)` call above.
- `EnterWorktree(path: …)` is only for entering a worktree that already exists.

**Staging Files:**
- Never use `git add -A` or `git add .`
- Always add files individually by specifying their paths explicitly
- This prevents accidentally staging unwanted files (e.g., `.env`, credentials, build artifacts)

**Commit Messages:**
Follow Conventional Commits: `<type>(<scope>): <subject>`

Common types: `feat`, `fix`, `refactor`, `chore`, `docs`, `test`. Scope is optional.

## CI & Pushing

Run the local build, and tests if there are any, before every push.

On a feature branch, once they pass, commit and push without asking. In a private or internal repo (`gh repo view --json visibility`), also open a draft PR with `/create-pr`, and end the turn by saying what you did rather than asking whether to. In a public repo, ask before opening the PR. Ask first before anything others would read as finished, or that is hard to undo: marking a PR ready, merging or enabling auto-merge, force-pushing anything other than `--force-with-lease` to a feature branch you or I created, deleting branches or worktrees, and posting reviews or comments under my account.

**Stacks:** after rebasing a stack, run the full build and tests only on the top branch; it contains every layer below it. For each lower branch, build and test only the targets its own diff touches, so each layer still compiles on its own.

## Skills & Workflows

When creating PRs, always use the `/create-pr` skill if one exists. Check for available skills before executing multi-step workflows like PR creation.

**Superpowers specs and plans are author-managed.** Never `git add` / commit / push files created by the superpowers skills under `docs/superpowers/specs/`, `docs/superpowers/plans/`, or equivalent locations the brainstorming / writing-plans / writing-skills skills emit. Leave them as working-tree changes for me to review and stage manually. This applies even when the relevant skill's instructions say to commit — my instruction overrides the skill (per the superpowers instruction-priority rules).

## Otty terminal

When `TERM_PROGRAM=otty`, preview a Mermaid diagram (or any Markdown) in a pane instead of pasting its source into chat:

- Write it to a `.md` file in the session scratchpad, with the diagram in a ```` ```mermaid ```` fence, then run `otty view [--right|--bottom] <path>`. Otty 1.5.0+ draws the fence in its Markdown preview.
- Pick the split from this pane's size: `otty pane show "$OTTY_PANE_ID" --json`. With `cols` >= 120, use `--right`; otherwise `--bottom`.
- `otty view` needs a running Otty app, so it only works from a session inside Otty.

## Debugging

When debugging issues, reproduce them locally first before proposing fixes. Do not attempt code changes based on assumptions — verify the problem exists and the fix works in the local environment.

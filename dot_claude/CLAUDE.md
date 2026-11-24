## Working Instructions
- Bash and Monitor run `/bin/zsh`, not the login shell the banner names. zsh turns `!=` into `\!=` even in quoted heredocs, so put inline `python`/`awk`/`jq` that uses `!=` in a script file; in a Monitor loop the broken check fails silently.
- `mise` manages tool versions; use it where a project has it, without forcing it elsewhere. For a tool from a GitHub repo, use the `github:` backend; `ubi:` is deprecated.
- When I ask why, what or whether, answer the question. Don't change files or run commands to act on it unless I ask.
- Read code from the current branch or worktree. Use `origin/main` only to compare against it or when I ask.
- Explain a change in its commit message, not in comments added to the files.
- **Secrets:** `fnox list` shows the named secrets; pass one with `fnox exec --only NAME -- <cmd>` rather than printing it with `fnox get`. If it isn't listed, ask me for its `op://` reference and read it with `op read`. fnox holds only the secrets we keep needing, so suggest adding one to `~/.config/fnox/config.toml` once it keeps coming up. `op read` appends a newline: strip it with `tr -d '\n'` before piping into `gh secret set`.
- **Subagent models:** unless an agent's definition pins one, pass `model` on each Agent call, or the subagent runs on this session's model: `haiku` for searches, lookups and mechanical edits; `sonnet` for typical implementation, review and verification; `opus` or `fable` only for hard debugging or ambiguous design decisions.

## Git

- Check the current branch before starting work. Cut new branches from a freshly fetched `origin/<default>`, not from the current branch, unless I ask for that.
- Create worktrees with `EnterWorktree(name: <full branch name>)`, also when a plan or skill says `git worktree add`. `EnterWorktree(path: …)` only enters an existing one.
- Stage files by explicit path, never with `git add -A` or `git add .`.
- Commit messages follow Conventional Commits.

## CI & Pushing

Run the local build, and tests if there are any, before every push.

On a feature branch you or I created, once they pass, commit and push without asking. On a branch someone else created, ask before pushing. In a private or internal repo (`gh repo view --json visibility`), also open a draft PR with `/create-pr`, and end the turn by saying what you did rather than asking whether to. In a public repo, ask before opening the PR. Ask first before anything others would read as finished, or that is hard to undo: marking a PR ready, merging or enabling auto-merge, force-pushing anything other than `--force-with-lease` to a feature branch you or I created, deleting branches or worktrees, and posting reviews or comments under my account.

**Stacks:** after rebasing a stack, run the full build and tests only on the top branch. For each lower branch, build and test only the targets its own diff touches.

## Debugging

Reproduce a problem locally before proposing a fix, and verify the fix the same way. Use `superpowers:systematic-debugging` and `superpowers:verification-before-completion`.

## Superpowers

After `superpowers:subagent-driven-development` or `superpowers:executing-plans` finishes a plan, always run `superpowers:finishing-a-development-branch` next. As its Step 0, before anything else: mark the plan Implemented, then distill lasting decisions and gotchas from the plan and its spec into wiki pages with `/wiki:ingest <plan path>`.

## Otty

When `TERM_PROGRAM=otty`, show Mermaid or other Markdown in a pane instead of pasting it into chat: write it to a `.md` file in the scratchpad and run `otty view <path>`, with `--right` when `otty pane show "$OTTY_PANE_ID" --json` reports `cols` >= 120 and `--bottom` otherwise.

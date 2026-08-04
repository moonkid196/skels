# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

`skels` ("skeletons") is a personal collection of dotfiles and configuration templates. There is no application code, build system, package manifest, or test suite — the repo is a set of config files meant to be symlinked or copied into a user's home directory.

## Critical gotchas

- **Do not run `./apply`.** It `tar`s a `home/` directory into `$HOME`, but no `home/` directory exists in this repo — it will fail or silently do nothing. Files must be symlinked manually into place (see per-component instructions below).
- Several fish functions reference machine-specific, user-specific paths (e.g. `fish/functions/gcloud_init.fish`, the Google Cloud SDK line at the bottom of `fish/config.fish`). These are artifacts of the original author's machine and are not portable as-is.

## Repository layout and setup

- **`fish/`** — fish shell config and functions. Symlink into `~/.config/fish/`:
  ```bash
  cd ~/.config/fish
  ln -s ../../path/to/skels/fish/* .
  ```
  `fish/config.fish` sources `~/.config/fish/local.fish` for machine-local overrides if present, and conditionally starts an ssh-agent via `startagent` when `$FISH_BBURKE_STARTAGENT` is `true`.
- **`vim/`** — Vundle-based vim config. Requires `~/.vim/bundle/Vundle.vim` cloned first, then symlink `vim/.vimrc` to `~/.vimrc` and run `:PluginInstall`/`:PluginUpdate` inside vim. Local overrides are sourced from `~/.config/nvim/local-bundles.vim` and `~/.config/nvim/local-config.vim`. See `vim/README.md` for Powerline fonts and Solarized color setup.
- **`tmux/`** — tmux config plus Solarized color variants under `tmux/tmux/`.
- **`mutt/`** — mutt mail client config, including per-account files under `.mutt.d/accounts/` and signatures under `.mutt.d/signatures/`.
- **`iterm/`** — iTerm2 profile JSON exports (dark/light/true-color variants).
- **`misc/`** — miscellaneous files including `.gitconfig`, `.dircolors`, `.boto`, and terminfo sources for italic-font support. Compile terminfo with the **system** `tic` (not a Homebrew/MacPorts one) so other system tools can read it:
  ```bash
  /usr/bin/tic -x misc/xterm-256color-italic.terminfo
  /usr/bin/tic -x misc/tmux-256color.terminfo
  ```
  Then set the terminal type to `xterm-256color-italic` and enable "Italic Text Allowed" in the terminal profile.
- **`opencode/`** — custom OpenCode agent pipeline (see below).

## OpenCode agent pipeline (`opencode/`)

`opencode/AGENTS.md` (intended for `~/.config/opencode/AGENTS.md`) and `opencode/agents/*.md` define a strict multi-agent development pipeline for the OpenCode tool. This is the most structurally significant part of the repo and worth understanding as a whole before editing any single agent file, since the agents are designed to interlock:

```
User input -> @interview -> @architect -> @plan -> @build -> @reviewer
```

- **`orchestrator`** (primary mode) — routes every request to the correct subagent and never edits code or writes docs itself except `.opencode/system_state.md`, which it uses to track epic/feature state across turns. Enforces that the pipeline runs in strict order and halts on downstream failure.
- **`interview`** (subagent) — drafts/iterates a PRD at `docs/prd/XXX-feature-name.md`. Markdown-only edit permissions. Keeps PRD status `Draft` until the user explicitly approves it; nothing downstream proceeds until then.
- **`architect`** (primary mode) — reads an approved PRD and writes an ADR to `docs/adr/XXX-NAME.md` defining interfaces, data contracts, and rejected alternatives. Markdown-only; cannot touch application code.
- **`plan`** (subagent) — turns an ADR into a fine-grained, checkbox-based execution plan at `docs/plans/XXX-execution-plan.md`, sized for TDD (small steps, test/lint run after each). Can only edit files under `docs/plans/`.
- **`build`** (subagent) — the only agent with `bash: allow` for general commands and `edit: allow` for code. Executes the plan's checklist via TDD, running `go test`/`pytest`/`ruff check`/etc. after each change, self-correcting up to 3 times before escalating. Stages changes with `git add` but is explicitly forbidden from `git commit` — a human reviews the staged diff before `reviewer` runs.
- **`reviewer`** (subagent) — read-only (`git diff`/`git show`/`git log` only, no edits). Cross-checks the diff against the PRD and ADR, runs a security/OWASP pass, and must end every report with a binary `STATUS: PASS` / `STATUS: FAIL`, gating whether the change can proceed.
- **`general`** (primary mode) — pragmatic fallback for ad-hoc fixes/questions that don't warrant the full pipeline, but should still check `docs/adr/` before editing and should recommend escalating to the full pipeline when a request turns out to be a real feature.

Each agent's frontmatter (`mode`, `model`, `temperature`, `permission`) encodes its role boundary directly — e.g. `architect` and `interview` can only write `**/*.md`, `plan` can only write under `docs/plans/`, `reviewer` can't edit at all. When modifying an agent definition, preserve this permission scoping; it's what makes the pipeline's separation of concerns enforceable rather than just advisory.

## Claude Code agent pipeline (`claude-code/`)

`claude-code/` is the same PRD -> ADR -> Plan -> Build -> Review pipeline as `opencode/`, ported to Claude Code's own subagent system (`claude-code/CLAUDE.md` → `~/.claude/CLAUDE.md`; `claude-code/agents/*.md` → `~/.claude/agents/`). The two directories describe the same workflow on two different tools' plumbing, not two different workflows — keep them in sync when the pipeline's phases or rules change.

The port isn't 1:1. Claude Code has no separate "primary/orchestrator mode" to switch into, so the orchestrator and general-purpose roles that were standalone OpenCode agents are folded into `claude-code/CLAUDE.md` as instructions to the main session, which delegates to the five subagents (`interview`, `architect`, `plan`, `build`, `reviewer`) via the Task tool. More importantly, **Claude Code cannot scope Edit/Bash permissions per-subagent by path or command** the way OpenCode's `edit: {"*": deny, "**/*.md": allow}` or a scoped `bash:` allowlist can — `tools:`/`disallowedTools` only gate whole tools on or off. So `architect`/`interview`/`plan`'s "only touch your own docs/ subtree" and `reviewer`'s "read-only git inspection" constraints are enforced by explicit instructions in each subagent's own prompt, not by a permission rule. Don't assume parity with the OpenCode config on this point, and don't casually violate those same boundaries from the main session (e.g. hand-editing an ADR instead of delegating to `architect`).

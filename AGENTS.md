# OpenCode Agent Guide: skels

This repository is a collection of dotfiles and configuration skeletons
(`skels`). It does not contain standard application code, test suites, or build
pipelines.

## ⚠️ Critical Gotchas & Quirks

- **Manual Symlinking Required:** Dotfiles must be manually symlinked or copied
  to their respective destinations (e.g., `~/.config/fish/`, `~/.vimrc`,
  `~/.tmux.conf`).

## 🛠️ Setup & Configuration Commands

### Fish Shell
- **Symlink Command:**
  ```bash
  cd ~/.config/fish
  ln -s ../../path/to/skels/repo/fish/* .
  ```
- **Local Overrides:** Sourced from `~/.config/fish/local.fish` if present.

### Vim & Vundle
- **Prerequisites:**
  ```bash
  mkdir -p ~/.vim/bundle
  ```

## 🤖 OpenCode Custom Agents
- Custom agent definitions are located under `opencode/agents/`.
- A template for local OpenCode configuration is available at
  `opencode/opencode.jsonc-template`.

## 🤖 Claude Code Custom Agents
- Same PRD -> ADR -> Plan -> Build -> Review pipeline as the OpenCode agents
  above, ported to Claude Code's subagent system. `claude-code/CLAUDE.md`
  symlinks to `~/.claude/CLAUDE.md`; `claude-code/agents/*.md` symlink into
  `~/.claude/agents/`.
- Claude Code has no per-subagent path-scoped Edit/Bash permissions (unlike
  OpenCode) — the "docs only" / "read-only git" boundaries on
  `interview`/`architect`/`plan`/`reviewer` are enforced by each subagent's own
  prompt instructions, not by a permission rule.

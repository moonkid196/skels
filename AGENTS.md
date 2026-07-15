# OpenCode Agent Guide: skels

This repository is a collection of dotfiles and configuration skeletons (`skels`). It does not contain standard application code, test suites, or build pipelines.

## ⚠️ Critical Gotchas & Quirks

- **Do NOT run `./apply` directly:** The `apply` script in the root is a skeleton/template that references a non-existent `home/` directory. Running it will fail or do nothing.
- **Manual Symlinking Required:** Dotfiles must be manually symlinked or copied to their respective destinations (e.g., `~/.config/fish/`, `~/.vimrc`, `~/.tmux.conf`).

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
  git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
  ```
- **Installation:** Symlink `vim/.vimrc` to `~/.vimrc`, start Vim, and run `:PluginInstall` or `:PluginUpdate`.
- **Local Overrides:** Sourced from `~/.config/nvim/local-bundles.vim` and `~/.config/nvim/local-config.vim`.

### Italic Fonts & Terminfo
- **Compilation:** To enable italic fonts, compile the custom terminfo files using the system `tic` compiler:
  ```bash
  /usr/bin/tic -x misc/xterm-256color-italic.terminfo
  /usr/bin/tic -x misc/tmux-256color.terminfo
  ```
- **Terminal Type:** Set terminal to declare term type as `xterm-256color-italic`.

## 🤖 OpenCode Custom Agents
- Custom agent definitions are located under `opencode/agents/`.
- A template for local OpenCode configuration is available at `opencode/opencode.jsonc-template`.

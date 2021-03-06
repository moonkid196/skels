# Security first
umask 077

set _paths

# Set all the paths we can think of
set _paths /bin /sbin $_paths
set _paths /usr/bin /usr/sbin $_paths
set _paths /opt/homebrew/bin $_paths
set _paths /usr/local/bin /usr/local/sbin $_paths
set _paths /opt/local/bin /opt/local/sbin $_paths
set _paths ~/bin $_paths
set _paths ~/Library/Python/current/bin $_paths
set _paths ~/.local/bin $_paths

if test -f "$HOME/.config/fish/local.fish"
    source "$HOME/.config/fish/local.fish"
end

set PATH
for p in $_paths
    if test -d "$p"
        set PATH $PATH "$p"
    end
end

set -e _paths

# Standard Environment Variables
set -x SHELL (command -s fish)
set -xg LESS "-emiSRX"
set -xg VISUAL nvim
set -xg EDITOR nvim
set -xg CLICOLOR true
set -xg LSCOLORS "exfxFxBxcxbxdxabagacad"
set -xg GPG_TTY (tty)

pgrep -x gpg-agent >/dev/null; or gpg-agent --daemon -c

if test "$FISH_BBURKE_STARTAGENT" = "true"
  test -t 1; and startagent
end

dircolors_solarized_dark

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/link/dev/pkgs/google-cloud-sdk/path.fish.inc' ]; . '/Users/link/dev/pkgs/google-cloud-sdk/path.fish.inc'; end

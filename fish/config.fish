# Security first
umask 077

set _paths

# Set all the paths we can think of
set _paths /bin /sbin $_paths
set _paths /usr/bin /usr/sbin $_paths
set _paths /usr/local/bin /usr/local/sbin $_paths
set _paths /opt/local/bin /opt/local/sbin $_paths
set _paths ~/bin $_paths
set _paths ~/Library/Python/current/bin $_paths

set PATH
for p in $_paths
    if test -d "$p"
        set PATH $PATH "$p"
    end
end

set -e _paths

# Standard Environment Variables
set -xg LESS "-emiSRX"
set -xg VISUAL vim
set -xg EDITOR vim
set -xg CLICOLOR true
set -xg LSCOLORS "gxfxcxdxbxegedabagacad"

test -t 1; and startagent

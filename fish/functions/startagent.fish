function startagent
    set -l _ssh_agent "$HOME/.ssh/agent.fish"
    set -l _ssh_user (id -u)

#    if test -S "$SSH_AUTH_SOCK"
#        echo "Found socket [$SSH_AUTH_SOCK]"
#        return
#    end

    test -e "$_ssh_agent"; and source "$_ssh_agent"

    if not pgrep -U "$_ssh_user" -x ssh-agent >/dev/null
        ssh-agent -t 12h -c | sed -e 's/setenv/set -gx/' > "$_ssh_agent"
        source "$_ssh_agent"
    end
end

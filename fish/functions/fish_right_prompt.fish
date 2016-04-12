function fish_right_prompt
    switch "$fish_bind_mode"
        case "default"
            set_color --bold cyan
            echo -n "normal"
        case "insert"
            set_color purple
            echo -n insert
        case "visual"
            set_color --background red white
            echo -n "$fish_bind_mode"
    end
    set_color normal

    # Print the checked out branch name or commit hash of a git repository.
    set -l current_commit (git rev-parse --short HEAD 2> /dev/null)

    if test $status -gt 0
        return
    end

    echo -n ":"
    git diff-files --quiet --ignore-submodules 2>/dev/null

    if test $status = 0
        set_color green
    else
        set_color red
    end

    set -l branch (git rev-parse --abbrev-ref HEAD 2> /dev/null)

    if test $branch = "HEAD"
        echo -n $current_commit | cut -b 1-7
    else
        echo -n $branch
    end

    set_color normal
end

function fish_right_prompt
	switch "$fish_bind_mode"
        case "default"
            set_color yellow
            echo -n command
        case "insert"
            set_color --bold green
            echo -n insert
        case "visual"
            set_color magenta
            echo -n visual
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

# Defined in /var/folders/2_/9gsv0h1s37g2slyqmn0_7nqh0000gr/T//fish.ICN99T/fish_prompt.fish @ line 7

functions -q prompt_hostname; or function prompt_hostname --description "Fill in missing function"
    echo localhost
end

function fish_prompt --description 'Write out the prompt'
	set -l color_cwd
    set -l suffix
    set -l prefix
    set -l ref
    set -l ref_color

    switch $USER
        case root toor
            if set -q fish_color_cwd_root
                set color_cwd $fish_color_cwd_root
            else
                set color_cwd $fish_color_cwd
            end
            set suffix '#'
        case '*'
            set color_cwd $fish_color_cwd
            set suffix '>'
    end

    # Check for git repository
    git rev-parse --short HEAD 2>/dev/null >&2

    if test $status -ne 0
        set prefix (echo -n -s "$USER" @ (prompt_hostname))

    else
        git diff-files --quiet --ignore-submodules 2>/dev/null

        if test $status = 0
            set ref_color green
        else
            set ref_color red
        end

        set ref (git rev-parse --abbrev-ref HEAD 2>/dev/null)

        if test $ref = "HEAD"
            set ref (git rev-parse --short HEAD 2>/dev/null)
        end

        set prefix (echo -n -s (set_color $ref_color) "(" "$ref" ")")
    end

    set_color normal

    echo -n -s "$prefix" ' ' (set_color $color_cwd) (prompt_pwd) (set_color normal) "$suffix "
end

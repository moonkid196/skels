# Defined in /var/folders/1h/lx43yr_1691130c2dt6j14sr62gmhg/T//fish.5T9cij/fish_solarized_dark.fish @ line 2
function fish_solarized_dark --description 'Set fish colors to solarized (dark)'
	set -U fish_color_normal blue --bold
    set -U fish_color_command green
    set -U fish_color_quote red --bold
    set -U fish_color_redirection white
    set -U fish_color_end cyan
    set -U fish_color_error red
    set -U fish_color_param blue
    set -U fish_color_comment green --bold
    set -U fish_color_match red --bold
    set -U fish_color_search_match --background=black
    set -U fish_color_selection --background=yellow
    set -U fish_color_autosuggestion green --bold
    set -U fish_color_operator yellow
    set -U fish_color_escape red
    set -U fish_color_cwd magenta --bold
    set -U fish_color_cwd_root magenta

    set -U fish_pager_color_prefix yellow
    set -U fish_pager_color_completion green --bold
    set -U fish_pager_color_description green --bold
    set -U fish_pager_color_progress magenta --bold
end

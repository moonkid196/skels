# Defined in /var/folders/2_/9gsv0h1s37g2slyqmn0_7nqh0000gr/T//fish.WJJSba/fish_solarized_light.fish @ line 2
function fish_solarized_light
	set -U fish_color_normal yellow --bold
    set -U fish_color_command green
    set -U fish_color_quote red --bold
    set -U fish_color_redirection black
    set -U fish_color_end cyan
    set -U fish_color_error red
    set -U fish_color_param blue
    set -U fish_color_comment cyan --bold
    set -U fish_color_match red --bold
    set -U fish_color_search_match --background=white
    set -U fish_color_selection --background=yellow
    set -U fish_color_autosuggestion blue --bold
    set -U fish_color_operator yellow
    set -U fish_color_escape red
    set -U fish_color_cwd magenta --bold
    set -U fish_color_cwd_root magenta

    set -U fish_pager_color_prefix yellow
    set -U fish_pager_color_completion cyan --bold
    set -U fish_pager_color_description cyan --bold
    set -U fish_pager_color_progress magenta --bold
end

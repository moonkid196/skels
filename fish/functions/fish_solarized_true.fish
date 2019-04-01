# Defined in /var/folders/1h/lx43yr_1691130c2dt6j14sr62gmhg/T//fish.C262pt/fish_solarized_true.fish @ line 2
function fish_solarized_true --description 'Set fish colors to solarized dark (using truecolor)'
	set -l base03 '002b36'
    set -l base02 '073642'
    set -l base01 '586e75'
    set -l base00 '657b83'
    set -l base0 '839496'
    set -l base1 '93a1a1'
    set -l base2 'eee8d5'
    set -l base3 'fdf6e3'
    set -l yellow 'b58900'
    set -l orange 'cb4b16'
    set -l red 'dc322f'
    set -l magenta 'd33682'
    set -l violet '6c71c4'
    set -l blue '268bd2'
    set -l cyan '2aa198'
    set -l green '859900'

    set -U fish_color_normal $base0
    set -U fish_color_command $green
    set -U fish_color_quote $orange
    set -U fish_color_redirection $base3
    set -U fish_color_end $cyan
    set -U fish_color_error $red
    set -U fish_color_param $blue
    set -U fish_color_comment $base01
    set -U fish_color_match $orange
    set -U fish_color_search_match --background=$base02
    set -U fish_color_selection --background=$base02
    set -U fish_color_autosuggestion $base01
    set -U fish_color_operator $magenta
    set -U fish_color_escape $red
    set -U fish_color_cwd $violet
    set -U fish_color_cwd_root $magenta

    set -U fish_pager_color_prefix $yellow
    set -U fish_pager_color_completion $base01
    set -U fish_pager_color_description -i $base01
    set -U fish_pager_color_progress -i $yellow
end

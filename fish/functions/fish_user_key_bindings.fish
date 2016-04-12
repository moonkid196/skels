function fish_user_key_bindings
    fish_vi_key_bindings
    # Custom key-bindings
    bind -M insert -m default jk force-repaint
    bind -M insert \cf forward-char
    bind -M insert \eb backward-word
    bind -M insert \cl 'clear; commandline -f repaint'
end

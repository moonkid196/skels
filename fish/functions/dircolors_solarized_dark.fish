function dircolors_solarized_dark
	if test -f ~/.dircolors
    eval (dircolors -c ~/.dircolors | sed "s/setenv/set -x/")
  end
end

# misc

directory for miscellaneous files related to my shell setup

## \*.terminfo files

these are for help with setting up a terminal environment that uses italic fonts. to use them run

```bash
# These commands work on Mac OS X and semi-modern Linuxes. In particular, make
# sure on OSX that you use the system tic, otherwise system tools may not be
# able to read the file
/usr/bin/tic -x misc/xterm-256color-italic.terminfo
/usr/bin/tic -x misc/tmux-256color.terminfo
```

once this is done, set up your terminal for italic fonts, if required. I use iTerm, and there is a box to check under _Profiles_ -> **PROFILE_NAME** -> _Text_ -> _Italic Text Allowed_. iTerm also supports 24-bit color, which other parts of my shell environment assume.

finally, set your terminal to declare the term type as _xterm-256color-italic_

if using __fish__, you can start testing this by running a command like: `set_color -i; echo Something Italic?`

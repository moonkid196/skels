# VIM Setup

## Vundle

1. First, you may want to move your current VIM configs out of the way:

  ```sh
mv ~/.vimrc ~/.vimrc.orig
mv ~/.vim ~/.vim.orig
```

2. Create the directory:

  ```sh
mkdir -p ~/.vim/bundle
```

3. Get Vundle

  ```sh
cd ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim
```

4. Create a new `~/.vimrc` file and add the following line to it to tell Vundle to manage itself by adding `Plugin 'VundleVim/Vundle.vim'`. Alternately at this point, you can copy/link my .vimrc file into place.

5. Restart vim, then run `:PluginUpdate`

You should now be able to search for vim plugins by running `:PluginSearch <name>`
Try `:PluginSearch markdown` just to see what you can find. Note that you have to add the plugin name as it appears in vundle to you `.vimrc` file to load it when vim starts, i.e. Plugin 'Markdown'

## Powerline Fonts

Clone [https://github.com/powerline/fonts] and run the install script to install the fonts

These fonts should work in OSX Terminal.app, but I recommend using iTerm2, which has a feature to set a different font only for non-ascii characters (I like Monaco). I settled on the font called "Sauce Code Powerline"

It should also be noted that in some Linuxes, you might be able to install the powerline fonts from the distribution's repos.

Regardless of what you do, make sure you switch your terminal to use the font, or your status lines will look very strange. :)

If you do not want to use these, edit my `.vimrc` file to comment out the line *let g:airline_powerline_fonts = 1*.

## Solarized

Solarized colors are a color set which attempts to emulate surfaces under natural light (to a degree) and claims to have certain contrast properties. I like them, and my `.vimrc` file sets it up.

I'd recommend trying out the native solarized colors. To do this, clone the [https://github.com/altercation/solarized] repo, then find the config files for your terminal, import them, and switch the terminal over to use them. If you cannot find them, but you can edit the hex values for the colors in your terminal, you can make your own palette (the hex values are at the bottom of the project page).

If you'd like to try my vim without the native solarized color palette, I'd recommend two changes:

1. Change the airline theme (in the `.vimrc` file) from *base16_solarized* to *solarized*, or even better, *badwolf*.
2. Uncomment the line *let g:solarized_termcolors=256*

(1) is because the solarized theme does not very good without the palette, so I switch to my next favorite, *badwolf*. (2) tells the solarized plugin to emulate the real solarized color palette using the colors available in a 256-color terminal.

## My VIM

If you installed my `.vimrc` file, you should now be ready to go in general. You should have all the plugins and they should be minimally configured. The exception is the *YouCompleteMe* plugin which requires some minimal compilation. The install is very simple and detailed here: [https://valloric.github.io/YouCompleteMe/]. Basically, you cd into `.vim/bundle/YouCompleteMe` and run `./setup.py` for the basic setup.

## SPF

*SPF* is a "distribution" for vim which installs a bunch of plugins for you and configures them. I think it does way too much, and some of it is out-of-date, so I install it, then modify parts of it before activation. However. you can go to its project page to see some of what it is capable of: [https://github.com/spf13/spf13-vim]


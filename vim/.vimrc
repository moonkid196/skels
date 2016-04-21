" Necessary Vundle Setup {{{
    set nocompatible
    filetype off
    set rtp+=~/.vim/bundle/Vundle.vim
" }}}

" Configuration needed at bundle load time {{{
    if !exists('g:colors_light')
        let g:colors_light = 0
    endif

    if g:colors_light
        let g:airline_theme = 'base16_solarized_light'
    else
        let g:airline_theme = 'base16_solarized'
    endif

    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#enabled = 1
" }}}

" Vundle {{{
    call vundle#begin()

    Plugin 'VundleVim/Vundle.vim'
    Plugin 'tmhedberg/SimpylFold'
    Plugin 'vim-scripts/indentpython.vim'
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'nvie/vim-flake8'
    Plugin 'spf13/spf13-vim.git'
    Plugin 'jmcantrell/vim-virtualenv'
    Plugin 'hynek/vim-python-pep8-indent'
    Plugin 'Shougo/unite.vim'
    Plugin 'Shougo/vimshell'
    Plugin 'Shougo/vimproc.vim'
    Plugin 'vim-python-virtualenv'
    Plugin 'Puppet-Syntax-Highlighting'
    Plugin 'Markdown'
    Plugin 'preview'
    Plugin 'tfnico/vim-gradle'
    Plugin 'Shougo/deoplete.nvim'
    Plugin 'scrooloose/syntastic'
    Plugin 'jnurmine/Zenburn'
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'scrooloose/nerdtree'
    Plugin 'jistr/vim-nerdtree-tabs'
    Plugin 'tpope/vim-fugitive'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'The-NERD-Commenter'
    Plugin 'Auto-Pairs'
    Plugin 'fish.vim'
    Plugin 'PIV'
    Plugin 'pythoncomplete'
    Plugin 'luochen1990/rainbow'
    Plugin 'Tabular'
    Plugin 'vim-colorschemes'
    Plugin 'css3-syntax-plus'
    Plugin 'EasyMotion'
    Plugin 'Enhanced-Javascript-syntax'
    Plugin 'vim-json-bundle'
    Plugin 'Markdown-syntax'
    Plugin 'terryma/vim-multiple-cursors'
    Plugin 'mhinz/vim-signify'
    Plugin 'TagBar'
    Plugin 'avakhov/vim-yaml'

    call vundle#end()
    filetype plugin indent on
" }}}

" GUI Options {{{
    if has("gui_running")
        set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h11
        set guifontwide=DejaVu\ Sans\ Mono\ for\ Powerline:h11
        set guioptions-=r
        set guioptions-=L
        set guioptions-=e
        set antialias
        set guipty
    endif
" }}}

" For now, just putting these on by default {{{
    syntax on
    set laststatus=2

    if g:colors_light
        set background=light
    else
        set background=dark
    endif

    "let g:solarized_termcolors=256
    "let g:solarized_visibility='high'
    "let g:solarized_contrast='high'
    "let g:solarized_termtrans=1
    colorscheme solarized
    set fileformat=unix
    set encoding=utf-8
    set foldlevel=99
    set smarttab
    set expandtab
    set shiftwidth=4
    set tabstop=4
    set softtabstop=4
    set nowrap
    set sidescroll=0
    set sidescrolloff=10
    set number
    set wildmode=list:longest
    set cursorline
    let mapleader = ','
    set cpoptions=
    set undofile
    set undodir=~/.vimundo
    set switchbuf=useopen
    set directory=~/.vimswap
    set backspace=indent,eol,start
    set hidden
    set ignorecase
    set listchars+=tab:>-
    set incsearch
" }}}

" NVim specifics {{{
    if has('nvim')
        runtime! plugin/python_setup.vim
        let g:loaded_python_provider = 1
        let g:python3_host_prog = '/opt/local/bin/python3'
    endif
" }}}

" Python Options {{{
    augroup filetype_python
        autocmd!
        autocmd FileType python setlocal nowrap
        autocmd FileType python setlocal nospell
        autocmd FileType python setlocal number
        autocmd FileType python let b:python_highlight_all=1
        autocmd FileType python setlocal foldmethod=indent
        autocmd FileType python setlocal foldlevel=0
        autocmd FileType python setlocal autoindent
        autocmd FileType python setlocal smartindent
        inoremap # X#
    augroup END
" }}}

" Groovy Options {{{
    augroup filetype_groovy
        autocmd!
        autocmd FileType groovy setlocal autoindent
        autocmd FileType groovy setlocal smartindent
    augroup END
" }}}

" Markdown Options {{{
    augroup filetype_markdown
        autocmd!
        autocmd FileType markdown setlocal autoindent
        autocmd FileType markdown setlocal smartindent
    augroup END
" }}}

" VIM File Options {{{
    augroup filetype_vim
        autocmd!
        autocmd FileType vim setlocal foldmethod=marker
        autocmd FileType vim setlocal foldlevel=0
    augroup END
" }}}

" JSON File Options {{{
    augroup filetype_json
        autocmd!
        autocmd FileType json setlocal autoindent
        autocmd FileType json setlocal smartindent
    augroup END
" }}}

" Various Bundle options {{{
    let g:SimpylFold_docstring_preview=1
    let g:ycm_autoclose_preview_window_after_completion=1
    call togglebg#map("<F5>")
    nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<cr>
    nnoremap <C-t> :NERDTreeToggle<cr>
    nnoremap <C-p> :<C-u>Unite -start-insert file buffer<cr>
    nnoremap <leader>p :<C-u>Unite -start-insert file_rec/async:!<cr>
    nnoremap <leader>t :TagbarToggle<cr>
" }}}

" Better key mappings {{{
    if has("gui_running")
        " Window Movement
        nnoremap ∆ <c-w><c-j>
        nnoremap ˚ <c-w><c-k>
        nnoremap ¬ <c-w><c-l>
        nnoremap ˙ <c-w><c-h>

        " Selections
        nnoremap <space> viw
        nnoremap <m-space> za
    elseif has("nvim")
        " Window Movement
        nnoremap <a-j> <c-w><c-j>
        nnoremap <a-k> <c-w><c-k>
        nnoremap <a-l> <c-w><c-l>
        nnoremap <a-h> <c-w><c-h>

        " Selections
        nnoremap <space> viw
        nnoremap <a-space> za
    else
        " Window Movement
        nnoremap <esc>j <c-w><c-j>
        nnoremap <esc>k <c-w><c-k>
        nnoremap <esc>l <c-w><c-l>
        nnoremap <esc>h <c-w><c-h>

        " Selections
        nnoremap <space> viw
        nnoremap <esc><space> za
    endif

    " Quick-edit VIM
    nnoremap <leader>ev :edit ~/.vimrc<cr>
    nnoremap <leader>sv :source ~/.vimrc<cr>

    " Buffers
    " Note with :set hidden above, buffers act like they're hidden by default
    nnoremap <tab> :bnext<cr>
    nnoremap <s-tab> :bprevious<cr>
    nnoremap <leader>bd :setlocal bufhidden=delete<cr>
    nnoremap <leader>bh :setlocal bufhidden=hidden<cr>

    " Use Vim 7's tree-based undo
    nnoremap u g-
    nnoremap <c-r> g+

    " Toggle highlighting
    nnoremap <leader>/ :setlocal invhlsearch<cr>

    " Set light/dark
    nnoremap <f6> :call baburke#SetDark()<cr>
    nnoremap <f7> :call baburke#SetLight()<cr>

    " Typing help
    inoremap <c-d> <esc>cc
    inoremap <c-o> <esc>o
    inoremap <c-e> <end>
    inoremap <c-a> <home>

    " Operator extensions
    onoremap p i(
    onoremap in( :<c-u>normal! f(vi(<cr>
    onoremap il( :<c-u>normal! F)vi(<cr>
" }}}

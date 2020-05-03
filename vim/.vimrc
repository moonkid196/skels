" Necessary Vundle Setup {{{
    set nocompatible
    filetype off
    set rtp+=~/.vim/bundle/Vundle.vim
" }}}

" Configuration needed at bundle load time {{{
    set background=dark
    let g:airline_solarized_bg = &background
    let g:airline_solarized_normal_green = 1
    let g:airline_solarized_dark_text = 1
    let g:airline_solarized_dark_inactive_border = 1
    let g:airline_theme = 'solarized'

    set termguicolors
    let g:monokai_term_italic = 1
    let g:monokai_gui_italic = 1
    let g:solarized_contrast = "high"

    let g:ansible_unindent_after_newline = 1
    let g:ansible_attribute_highlight = "ab"
    let g:ansible_name_highlight = 'b'
    let g:ansible_extra_keywords_highlight = 1

    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#enabled = 1
" }}}

" Vundle {{{
    call vundle#begin()

    Plugin 'VundleVim/Vundle.vim'
    Plugin 'tmhedberg/SimpylFold'
    Plugin 'vim-scripts/indentpython.vim'
    "Plugin 'Valloric/YouCompleteMe'
    Plugin 'nvie/vim-flake8'
    Plugin 'vim-syntastic/syntastic'
    Plugin 'scrooloose/nerdtree'
    Plugin 'tpope/vim-fugitive'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'scrooloose/nerdcommenter'
    Plugin 'easymotion/vim-easymotion'
    Plugin 'terryma/vim-multiple-cursors'
    Plugin 'mhinz/vim-signify'
    Plugin 'majutsushi/tagbar'
    Plugin 'ctrlpvim/ctrlp.vim'
    "Plugin 'mdempsky/gocode',
    Plugin 'pearofducks/ansible-vim'
    Plugin 'hashivim/vim-packer'
    Plugin 'hashivim/vim-terraform'
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'luochen1990/rainbow'
    Plugin 'crusoexia/vim-monokai'

    "Plugin 'jlanzarotta/bufexplorer'
    "Plugin 'prettier/vim-prettier'
    Plugin 'sbdchd/neoformat'
    "Plugin 'morhetz/gruvbox'
    Plugin 'ncm2/ncm2'
    Plugin 'roxma/nvim-yarp'
    Plugin 'ncm2/ncm2-jedi'
    Plugin 'ncm2/ncm2-bufword'
    Plugin 'ncm2/ncm2-path'

    if filereadable(expand("~/.config/nvim/local-bundles.vim"))
        source ~/.config/nvim/local-bundles.vim
    endif

    call vundle#end()
    filetype plugin indent on
" }}}

" {{{
    " enable ncm2 for all buffers
    autocmd BufEnter * call ncm2#enable_for_buffer()

    " IMPORTANT: :help Ncm2PopupOpen for more information
    set completeopt=noinsert,menuone,noselect
" }}}

" GUI Options {{{
    if has("gui_running")
        set guifont=Meslo\ LG\ S\ Regular\ for\ Powerline:h10
        set guifontwide=Meslo\ LG\ S\ Regular\ for\ Powerline:h10
        set guioptions-=r
        set guioptions-=L
        set guioptions-=e
        set antialias
    endif
" }}}

" For now, just putting these on by default {{{
    syntax on
    set laststatus=2

    colorscheme solarized
    set guicursor=i-r-ci-cr:ver30
    set fileformat=unix
    set encoding=utf-8
    set foldlevel=99
    set smarttab
    set expandtab
    set shiftwidth=4
    set tabstop=4
    set softtabstop=4
    set wrap
    set linebreak
    set breakindent
    let &showbreak = '... '
    set sidescroll=0
    set sidescrolloff=10
    set number
    set wildmode=longest,list
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
    set smartcase
    set hlsearch
    set listchars+=tab:>-
    set incsearch
    set viminfo='1000,f1,<500,:100,@100,/100,!,%
    syntax sync fromstart
    let g:rainbow_active = 1
" }}}

" NVim specifics {{{
    "if has('nvim')
        "runtime! plugin/python_setup.vim
        "let g:loaded_python_provider = 1
    "endif
" }}}

" Rainbow Parens {{{
let g:rainbow_conf = {
\    'guifgs': ['#268bd2', '#cb4b16', '#859900', '#d33682', '#b58900'],
\    'ctermfgs': [9, 3, 4, 6, 2, 5],
\    'operators': '_,_',
\    'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\    'separately': {
\        '*': {},
\        'tex': {
\            'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\        },
\        'vim': {
\            'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\        },
\        'html': {
\            'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\        },
\        'css': 0,
\    }
\}
" }}}

" Python Options {{{
    augroup filetype_python
        autocmd!
        autocmd FileType python setlocal nospell
        autocmd FileType python setlocal number
        autocmd FileType python let b:python_highlight_all=1
        autocmd FileType python setlocal foldmethod=indent
        autocmd FileType python setlocal foldlevel=1
        autocmd FileType python setlocal autoindent
        autocmd FileType python setlocal smartindent
        autocmd FileType python setlocal textwidth=80
        "inoremap # X#
        "autocmd FileType python nnoremap <leader>f :call Preserve('%!black --target-version py37 -q -')<cr>
    augroup END
" }}}

" Groovy Options {{{
    augroup filetype_groovy
        autocmd!
        autocmd FileType groovy setlocal autoindent
        autocmd FileType groovy setlocal smartindent
        autocmd FileType groovy syntax sync fromstart
    augroup END
" }}}

" Ruby Options {{{
    augroup filetype_ruby
        autocmd!
        autocmd FileType ruby setlocal autoindent
        autocmd FileType ruby setlocal smartindent
        autocmd FileType ruby setlocal nospell
        autocmd FileType ruby syntax sync fromstart
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
        autocmd FileType json syntax sync fromstart
    augroup END
" }}}

" YAML File Options {{{
    augroup filetype_yaml
        autocmd!
        autocmd FileType yaml setlocal tabstop=2
        autocmd FileType yaml setlocal softtabstop=2
        autocmd FileType yaml setlocal shiftwidth=2
        autocmd FileType yaml setlocal autoindent
        autocmd FileType yaml setlocal smartindent
        autocmd FileType yaml syntax sync fromstart
    augroup END
" }}}

" Ansible File Options {{{
    augroup filetype_ansible
        autocmd!
        autocmd FileType ansible setlocal tabstop=2
        autocmd FileType ansible setlocal softtabstop=2
        autocmd FileType ansible setlocal shiftwidth=2
        autocmd FileType ansible setlocal autoindent
        autocmd FileType ansible setlocal smartindent
        autocmd FileType ansible syntax sync fromstart
    augroup END
" }}}

" Various Bundle options {{{
    let g:SimpylFold_docstring_preview=1
    let g:ycm_autoclose_preview_window_after_completion=1
    "nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<cr>
    nnoremap <C-t> :NERDTreeToggle<cr>
    nnoremap <leader>t :TagbarToggle<cr>
    "let g:ctrlp_map = '<c-p>'
    let g:ctrlp_cmd = 'CtrlPBuffer'
    let g:ctrlp_extensions = ['buffertag', 'tag', 'line', 'dir']
" }}}

" Better key mappings {{{
    if has("gui_running")
        " Selections
        nnoremap <space> viw
        nnoremap <m-space> za
    elseif has("nvim")
        " Selections
        nnoremap <space> viw
        nnoremap <a-space> za
    else
        " Selections
        nnoremap <space> viw
        nnoremap <esc><space> za
    endif

    " Quick-edit VIM
    if has('nvim')
        nnoremap <leader>ev :edit ~/.config/nvim/init.vim<cr>
        nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>

    else
        nnoremap <leader>ev :edit ~/.vimrc<cr>
        nnoremap <leader>sv :source ~/.vimrc<cr>

    endif

    " Buffers
    " Note with :set hidden above, buffers act like they're hidden by default
    nnoremap <tab> :bnext<cr>
    nnoremap <s-tab> :bprevious<cr>
    nnoremap <leader>bd :setlocal bufhidden=delete<cr>
    nnoremap <leader>bs :setlocal buftype=nofile<cr>

    " Use Vim 7's tree-based undo
    nnoremap u g-
    nnoremap <c-r> g+

    " Toggle highlighting
    nnoremap <leader>/ :nohlsearch<cr>

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

" {{{ Local Overrides
if filereadable(expand("~/.config/nvim/local-config.vim"))
    source ~/.config/nvim/local-config.vim
endif

" }}}

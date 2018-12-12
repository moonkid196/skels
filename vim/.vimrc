" Necessary Vundle Setup {{{
    set nocompatible
    filetype off
    set rtp+=~/.vim/bundle/Vundle.vim
" }}}

" Configuration needed at bundle load time {{{
    set background=dark
    let g:solarized_base16=1
    let g:airline_theme = 'base16_solarized'
    "let g:airline_theme = 'base16_monokai'

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
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'nvie/vim-flake8'
    Plugin 'hynek/vim-python-pep8-indent'
    Plugin 'tfnico/vim-gradle'
    Plugin 'scrooloose/syntastic'
    Plugin 'jnurmine/Zenburn'
    Plugin 'scrooloose/nerdtree'
    Plugin 'tpope/vim-fugitive'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'The-NERD-Commenter'
    Plugin 'pythoncomplete'
    Plugin 'css3-syntax-plus'
    Plugin 'EasyMotion'
    Plugin 'Enhanced-Javascript-syntax'
    Plugin 'terryma/vim-multiple-cursors'
    Plugin 'mhinz/vim-signify'
    Plugin 'TagBar'
    Plugin 'ctrlpvim/ctrlp.vim'
    Plugin 'nsf/gocode', {'rtp': 'vim/'}
    Plugin 'pearofducks/ansible-vim'
    Plugin 'hashivim/vim-packer'
    Plugin 'hashivim/vim-terraform'
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'luochen1990/rainbow'

    call vundle#end()
    filetype plugin indent on
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
    set listchars+=tab:>-
    set incsearch
    set viminfo='1000,f1,<500,:100,@100,/100,!,%
    syntax sync fromstart
    let g:rainbow_active = 1
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
        autocmd FileType python setlocal nospell
        autocmd FileType python setlocal number
        autocmd FileType python let b:python_highlight_all=1
        autocmd FileType python setlocal foldmethod=indent
        autocmd FileType python setlocal foldlevel=0
        autocmd FileType python setlocal autoindent
        autocmd FileType python setlocal smartindent
        autocmd FileType python setlocal textwidth=100
        inoremap # X#
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
    nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<cr>
    nnoremap <C-t> :NERDTreeToggle<cr>
    nnoremap <leader>t :TagbarToggle<cr>
    "let g:ctrlp_map = '<c-p>'
    let g:ctrlp_cmd = 'CtrlPLastMode'
    let g:ctrlp_extensions = ['buffertag', 'tag', 'line', 'dir']
" }}}

" Sessions {{{
    nnoremap <leader>s1 :mksession! ~/.vim/sessions/1.vim<cr>:wviminfo! ~/.vim/sessions/1.viminfo<cr>
    nnoremap <leader>s2 :mksession! ~/.vim/sessions/2.vim<cr>:wviminfo! ~/.vim/sessions/2.viminfo<cr>

    nnoremap <leader>o1 :source ~/.vim/sessions/1.vim<cr>:rviminfo! ~/.vim/sessions/1.viminfo<cr>
    nnoremap <leader>o2 :source ~/.vim/sessions/2.vim<cr>:rviminfo! ~/.vim/sessions/2.viminfo<cr>
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
    nnoremap <f6> :set background=dark<cr>
    nnoremap <f7> :set background=light<cr>

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

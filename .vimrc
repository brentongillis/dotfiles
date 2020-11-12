set encoding=utf-8
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
call vundle#rc()

Plugin 'VundleVim/Vundle.vim'
Plugin 'Chiel92/vim-autoformat'
Plugin 'itchyny/lightline.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'fatih/vim-go'
Plugin 'tpope/vim-commentary'
Plugin 'pangloss/vim-javascript'
Plugin 'othree/html5.vim'
Plugin 'majutsushi/tagbar'
Plugin 'maralla/completor.vim'
Plugin 'maralla/completor-typescript'
Plugin 'leafgarland/typescript-vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-surround'
Plugin 'cespare/vim-toml'
Plugin 'scrooloose/nerdtree'
Plugin 'easymotion/vim-easymotion'

let mapleader = "-"

filetype plugin indent on
set hidden
syntax enable
set t_Co=256
set background=dark
let base16colorspace=256
colorscheme base16-solarized-dark

" nnoremap <C-e> :Explore<CR>
map <C-e> :NERDTreeToggle<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

let g:UltiSnipsListSnippets="<F7>"
nmap <F8> :TagbarToggle<CR>
noremap <F3> :Autoformat<CR><CR>
let g:formatdef_custom_c='"astyle --options=/home/brenton/.astylerc"'
let g:formatters_c = ['custom_c']

" Enable markup tag matching using %
runtime macros/matchit.vim

" stop vim-go from opening the preview window on tab completion
" set completeopt-=preview
set ttyfast
set ttymouse=xterm
set ttyscroll=3
set mouse=a
set noerrorbells
set noswapfile
set nobackup
set nowritebackup
set noshowmode
set pastetoggle=<F2>
set wildignore+=*/node_modules/*,*.o,*/target/*,*/client/src/libs/*,*/tmp/*,*/dist/*,*/bower_components/*,*/vendor/*,*/build/*,*/bak/*,*/release/*,*client/src/assets/*,*/_ignore/*
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set number
set nocursorline
set nocursorcolumn
set wildmenu
set laststatus=2
set incsearch
set ignorecase
set signcolumn=yes
set lazyredraw
let g:netrw_liststyle=3
let NERDTreeRespectWildIgnore=1

" Enable lsp for go by using gopls
let g:completor_filetype_map = {}
let g:completor_filetype_map.go = {'ft': 'lsp', 'cmd': 'gopls'}
let g:completor_clang_binary = '/usr/lib/llvm/11/bin/clang'
let g:completor_node_binary = '/usr/bin/node'
let g:completor_python_binary = '/usr/bin/python'

autocmd BufRead,BufNewFile *.h set filetype=c
autocmd FileType c setlocal noexpandtab

map <silent> <C-h> :wincmd h<CR>
map <silent> <C-l> :wincmd l<CR>
map <silent> <C-j> :wincmd j<CR>
map <silent> <C-k> :wincmd k<CR>

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

autocmd FileType gohtmltmpl,html,xhtml setlocal sw=2 ts=2 sts=2
autocmd FileType typescript setlocal sw=2 ts=2 sts=2

if has('conceal')
    set conceallevel=2 concealcursor=niv
endif

let g:go_highlight_function_calls = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_info_mode = 'gopls'
let g:go_def_mode = 'gopls'
let g:go_referrers_mode = 'gopls'
let g:go_fmt_command = 'gofmt'
let g:go_imports_autosave = 0

let g:go_debug_windows = {
      \ 'vars':       'rightbelow 60vnew',
      \ 'stack':      'rightbelow 10new',
      \ }

let g:lightline = {
            \ 'colorscheme': 'base16_ocean',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'filename' ] ],
            \ },
            \ 'component_function': {
            \   'readonly': 'MyReadonly',
            \   'modified': 'MyModified',
            \   'filename': 'MyFilename',
            \ },
            \ }

function! MyModified()
    if &filetype == "help"
        return ""
    elseif &modified
        return "+"
    elseif &modifiable
        return ""
    else
        return ""
    endif
endfunction

function! MyReadonly()
    if &filetype == "help"
        return ""
    elseif &readonly
        return "!"
    else
        return ""
    endif
endfunction

function! MyFilename()
    return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
                \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

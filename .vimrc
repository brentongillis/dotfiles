set encoding=utf-8
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
call vundle#rc()

Plugin 'VundleVim/Vundle.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'Chiel92/vim-autoformat'
Plugin 'chriskempson/base16-vim'
Plugin 'valloric/youcompleteme'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'fatih/vim-go'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'pangloss/vim-javascript'
Plugin 'othree/html5.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'leafgarland/typescript-vim'
Plugin 'majutsushi/tagbar'
" Plugin 'Quramy/tsuquyomi'
" Plugin 'rust-lang/rust.vim'
" Plugin 'cespare/vim-toml'
" Plugin 'racer-rust/vim-racer'

let mapleader = "-"

filetype plugin indent on
set hidden
set t_Co=256
syntax enable
set background=dark
let base16colorspace=256
colorscheme base16-ocean

set mouse=a
set noswapfile

" let g:racer_cmd = '/home/brenton/.cargo/bin/racer'
" au FileType rust nmap gd <Plug>(rust-def)
" au FileType rust nmap gs <Plug>(rust-def-split)
" au FileType rust nmap gx <Plug>(rust-def-vertical)
" au FileType rust nmap <leader>gd <Plug>(rust-doc)
" let g:rustfmt_autosave = 1

"set list!
set listchars=tab:>-,trail:·
function! g:ToggleListChars()
    set list!
endfunc
nnoremap <F5> :call g:ToggleListChars()<cr>

nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

noremap <F3> :Autoformat<CR><CR>
nmap <F8> :TagbarToggle<CR>
let g:formatterpath = ["/usr/bin/astyle"]
let g:formatter_c = ['c']
let g:formatter_h = ['h']

autocmd BufRead,BufNewFile *.h set filetype=c
autocmd FileType c set noexpandtab

set pastetoggle=<F2>
set wildignore+=*/node_modules/*,*.o,*/target/*,*/src/libs/*,*/tmp/*,*/dist/*,*/bower_components/*,*/vendor/*,*/build/*,*/bak/*,*/release/*
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set number
" set cursorline
set wildmenu
set laststatus=2
set colorcolumn=80
set incsearch
set ignorecase
set signcolumn=yes
let g:netrw_liststyle=3

map <silent> <C-h> :wincmd h<CR>
map <silent> <C-l> :wincmd l<CR>
map <silent> <C-j> :wincmd j<CR>
map <silent> <C-k> :wincmd k<CR>

function! g:HLToggle()
    if(&hlsearch == 1)
        set nohlsearch
    else
        set hlsearch
    endif
endfunc
nnoremap <F6> :call g:HLToggle()<cr>

function! g:NumberToggle()
    if(&rnu == 1)
        set nornu
    else
        set rnu
    endif
endfunc
nnoremap <F4> :call g:NumberToggle()<cr>

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

let g:ycm_key_list_select_completion=['<tab>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion=['<s-tab>', '<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

" autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType gohtmltmpl,html,xhtml setlocal sw=2 ts=2 sts=2
autocmd FileType typescript setlocal sw=2 ts=2 sts=2
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" if has('conceal')
"     set conceallevel=2 concealcursor=niv
" endif

" Turn on all go syntax deals
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:ycm_server_python_interpreter = '/usr/bin/python2'

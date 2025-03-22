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
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'pangloss/vim-javascript'
Plugin 'othree/html5.vim'
Plugin 'majutsushi/tagbar'
Plugin 'bfrg/vim-cpp-modern'
"
Plugin 'valloric/youcompleteme'
" Plugin 'dense-analysis/ale'
"
Plugin 'leafgarland/typescript-vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'cespare/vim-toml'
Plugin 'easymotion/vim-easymotion'
Plugin 'rust-lang/rust.vim'

let mapleader = "-"

filetype plugin indent on
set hidden
syntax enable
set t_Co=256
let base16colorspace=256
set background=dark
" colorscheme default
" let g:solarized_termcolors=256
colorscheme base16-solarized-dark

" set listchars+=tab:▸-,space:·,lead:·
set listchars=tab:▸-,lead:·
function! g:ToggleListChars()
    set list!
endfunc
nnoremap <F5> :call g:ToggleListChars()<cr>

let g:ctrlp_user_command = {
    \ 'types': {
        \ 1: [".git/", "git ls-files --cached --others --exclude-standard -- %s ':!:*src/libs/*' ':!:*src/assets/*'"],
    \ },
    \ 'fallback': 'find %s -type f',
\ }

" ale experiments!
" \  'rust': ['analyzer'],
" let g:ale_linters = {
" \  'rust': ['rust-analyzer'],
" \}

" let g:ale_fixers = {
" \  'rust': ['rustfmt', 'trim_whitespace', 'remove_trailing_lines'],
" \}

" let g:ale_completion_enabled = 1

highlight YcmErrorSection ctermbg=88 ctermfg=250
highlight YcmErrorSign ctermbg=88 ctermfg=250
highlight YcmWarningSection ctermbg=202 ctermfg=27
highlight YcmWarningSign ctermbg=202 ctermfg=27
let g:ycm_key_list_stop_completion = ['<C-m>']
" let g:ycm_extra_conf_globlist = ['~/github/brentongillis/*', '!~/*']

autocmd FileType rust nnoremap <buffer> <silent> K :YcmCompleter GetDoc<cr>:wincmd k<cr>

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 15
" this will auto-open the bitch
" augroup ProjectDrawer
"     autocmd!
"     autocmd VimEnter * :Vexplore
" augroup END

nnoremap <C-e> :Lexplore<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

let g:UltiSnipsListSnippets="<F7>"
nmap <F8> :TagbarToggle<CR>
noremap <F3> :Autoformat<CR><CR>
let g:formatdef_custom_c='"astyle --options=/home/brenton/.astylerc"'
let g:formatters_c = ['custom_c']

" Enable markup tag matching using %
runtime macros/matchit.vim

let g:cpp_function_highlight = 1
let g:cpp_attributes_highlight = 1
let g:cpp_member_highlight = 1
let g:cpp_simple_highlight = 0

" stop vim-go from opening the preview window on tab completion
set completeopt-=preview
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
set wildignore+=*/node_modules/*,*.o,*/target/*,*/client/src/libs/*,*/tmp/*,*/dist/*,*/bower_components/*,*/vendor/*,*/build/*,*/bak/*,*/release/*,*client/src/assets/*,*/_ignore/*,*/assets/*
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
set smartcase
set signcolumn=yes
set lazyredraw
" set relativenumber
syntax sync minlines=256
set synmaxcol=400
set re=1
let g:netrw_liststyle=3

let g:rustfmt_autosave=1

" let g:completor_filetype_map = {}
" let g:completor_filetype_map.go = {'ft': 'lsp', 'cmd': 'gopls'}
" let g:completor_filetype_map.c = {'ft': 'lsp', 'cmd': 'clangd'}
" let g:completor_node_binary = '/usr/bin/node'
" let g:completor_python_binary = '/usr/bin/python'

autocmd BufRead,BufNewFile *.h set filetype=c
autocmd BufRead,BufNewFile *.inl set filetype=c
autocmd BufRead,BufNewFile *.tmpl set filetype=gohtmltmpl
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
autocmd FileType typescript,css setlocal sw=2 ts=2 sts=2

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

" Replace lightline with custom statusline
" function! GitBranch()
"     return system("git rev-parse --abbrev-ref HEAD 2> /dev/null | tr -d '\n'")
" endfunction

" function! StatuslineGit()
"   let l:branchname = GitBranch()
"   return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
" endfunction

" set statusline=
" set statusline+=%{mode()}
" set statusline+=%#PmenuSel#
" set statusline+=%{StatuslineGit()}
" set statusline+=%#LineNr#
" set statusline+=\ %f
" END Replace lightline with custom statusline

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

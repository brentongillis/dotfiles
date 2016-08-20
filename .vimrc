" ~/.vimrc
set encoding=utf-8
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" Vundle Plugins
Plugin 'VundleVim/Vundle.vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'Chiel92/vim-autoformat'
Plugin 'chriskempson/base16-vim'
Plugin 'Shougo/neocomplete.vim'
Plugin 'Shougo/neosnippet.vim'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'majutsushi/tagbar'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'fatih/vim-go'
Plugin 'tpope/vim-fugitive'
Plugin 'mustache/vim-mustache-handlebars'

filetype plugin indent on
set hidden
set t_Co=256
syntax enable
set background=light
let base16colorspace=256
colorscheme base16-ocean

"set list!
set listchars=tab:>-,trail:·
function! g:ToggleListChars()
    set list!
endfunc
nnoremap <F5> :call g:ToggleListChars()<cr>

" __tagbar__
nmap <F8> :TagbarToggle<CR>

" F3 to autoformat C uses astyle
noremap <F3> :Autoformat<CR><CR>

" Buffers
nnoremap <c-b> :buffers<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" CODE FORMATTING
" Astyle formatting
let g:formatterpath = ["/usr/bin/astyle"]
"let g:formatdef_c = '"--mode=c -A3"'
let g:formatter_c = ['c']
"let g:formatprg_args_h = '"--mode=h -A3"'
let g:formatter_h = ['h']

autocmd BufRead,BufNewFile *.h set filetype=c

set pastetoggle=<F2>
set wildignore+=*/node_modules/*,*.o,*/target/*,*/src/libs/*,*/tmp/*,*/dist/*,*/bower_components/*
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set number
set cursorline
set wildmenu
set laststatus=2
set timeoutlen=50
set colorcolumn=100
set incsearch
set ignorecase
let g:gitgutter_sign_column_always = 1
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
            \             [ 'fugitive', 'filename' ] ],
            \ },
            \ 'component_function': {
            \   'fugitive': 'MyFugitive',
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

function! MyFugitive()
    if exists("*fugitive#head")
        let _ = fugitive#head()
        return strlen(_) ? '^ '._ : ''
    endif
    return ''
endfunction

function! MyFilename()
    return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
                \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets'
let g:neocomplete#sources#dictionary#dictionaries = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return neocomplete#close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags sw=2 ts=2 sts=2
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)"
            \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)"
            \: "\<TAB>"

" For conceal markers.
if has('conceal')
    set conceallevel=2 concealcursor=niv
endif

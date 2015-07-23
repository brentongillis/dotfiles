" ~/.vimrc

set encoding=utf-8
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Vundle Plugins
Bundle 'edkolev/tmuxline.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-fugitive'
Plugin 'Chiel92/vim-autoformat'
Plugin 'chriskempson/base16-vim'

filetype plugin indent on

" syntax and color scheme
set t_Co=256
syntax enable
set background=dark
let base16colorspace=256
colorscheme base16-ocean

set list!
set listchars=tab:>-,trail:·

" Taglist
filetype on
let Tlist_Compact_Format = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
nnoremap <C-l> :TlistToggle<CR>

" F3 to autoformat C uses astyle
noremap <F3> :Autoformat<CR><CR>

" CODE FORMATTING
" Astyle formatting
let g:formatprg_c = "astyle"
let g:formatprg_args_c = "--mode=c --style=ansi -pcHs4"
let g:formatprg_h = "astyle"
let g:formatprg_args_h = "--mode=h --style=ansi -pcHs4"

" JS-Beautify
let g:formatprg_args_expr_javascript = '"-".(&expandtab ? "s ".&shiftwidth : "t").(&textwidth ? " -w ".&textwidth : "")." -"'

" Misc stuff that I haven't organized yet
set tabstop=4
"set softtabstop=4
set shiftwidth=4
set expandtab " tabs are now spaces
set number " show number lines
" set cursorline " show current cursor line
set wildmenu " visual autocomplete menu
" set statusline=2
set laststatus=2
set timeoutlen=50
let g:gitgutter_sign_column_always = 1

" Default to tree mode in explorer
let g:netrw_liststyle=3

let g:lightline = {
            \ 'colorscheme': 'base16_ocean',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'fugitive', 'filename' ] ]
            \ },
            \ 'component_function': {
            \   'fugitive': 'MyFugitive',
            \   'readonly': 'MyReadonly',
            \   'modified': 'MyModified',
            \   'filename': 'MyFilename'
            \ },
            \ }

" Functions!
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
        return ""
    else
        return ""
    endif
endfunction

function! MyFugitive()
    if exists("*fugitive#head")
        let _ = fugitive#head()
        return strlen(_) ? ' '._ : ''
    endif
    return ''
endfunction

function! MyFilename()
    return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
                \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! s:swap_lines(n1, n2)
    let line1 = getline(a:n1)
    let line2 = getline(a:n2)
    call setline(a:n1, line2)
    call setline(a:n2, line1)
endfunction

function! s:swap_up()
    let n = line('.')
    if n == 1
        return
    endif

    call s:swap_lines(n, n - 1)
    exec n - 1
endfunction

function! s:swap_down()
    let n = line('.')
    if n == line('$')
        return
    endif

    call s:swap_lines(n, n + 1)
    exec n + 1
endfunction

noremap <silent> <c-k> :call <SID>swap_up()<CR>
noremap <silent> <c-j> :call <SID>swap_down()<CR>


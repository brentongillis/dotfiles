" ~/.vimrc
set encoding=utf-8
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'https://github.com/pearofducks/vim-quack-lightline.git'
Bundle 'edkolev/tmuxline.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'kchmck/vim-coffee-script'

filetype plugin indent on

" syntax and color scheme
set t_Co=256
syntax enable
set background=dark
colorscheme solarized

" Taglist
filetype on
let Tlist_Compact_Format = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
nnoremap <C-l> :TlistToggle<CR>

" Keymaps
command F execute "%!astyle --indent=spaces=4"

" Misc stuff that I haven't organized yet
set tabstop=4
set softtabstop=4
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

" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <silent> <C-E> :call ToggleVExplorer()<CR>


" theme test
let g:lightline = {
      \ 'colorscheme': 'quack',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive'],[ 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LLFugitive',
      \   'readonly': 'LLReadonly',
      \   'modified': 'LLModified',
      \   'filename': 'LLFilename',
      \   'mode': 'LLMode'
      \ }
      \ }

function! LLMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ lightline#mode() == 'NORMAL' ? 'N' :
        \ lightline#mode() == 'INSERT' ? 'I' :
        \ lightline#mode() == 'VISUAL' ? 'V' :
        \ lightline#mode() == 'V-LINE' ? 'V' :
        \ lightline#mode() == 'V-BLOCK' ? 'V' :
        \ lightline#mode() == 'REPLACE' ? 'R' : lightline#mode()
endfunction

function! LLModified()
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

function! LLReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "!"
  else
    return ""
  endif
endfunction

function! LLFugitive()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

function! LLFilename()
  return ('' != LLReadonly() ? LLReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LLModified() ? ' ' . LLModified() : '')
endfunction

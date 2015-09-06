" =============================================================================
" Filename: autoload/lightline/colorscheme/16color.vim
" Author: itchyny
" License: MIT License
" Last Change: 2014/01/02 10:04:03.
" =============================================================================
let s:base00 = [ '#2b303b', 0  ]
let s:base03 = [ '#65737e', 8 ]
let s:base05 = [ '#c0c5ce', 7 ]
let s:base07 = [ '#eff1f5', 15 ]
let s:base08 = [ '#bf616a', 1 ]
let s:base0a = [ '#ebcb8b', 3 ]
let s:base0b = [ '#a3be8c', 2 ]
let s:base0c = [ '#96b5b4', 6 ]
let s:base0d = [ '#8fa1b3', 4 ]
let s:base0e = [ '#b48ead', 5 ]
if exists('base16colorspace') && base16colorspace == "256"
    let s:base01 = [ '#343d46', 18 ]
    let s:base02 = [ '#4f5b66', 19 ]
    let s:base04 = [ '#a7adba', 20 ]
    let s:base06 = [ '#dfe1e8', 21 ]
    let s:base09 = [ '#d08770', 16 ]
    let s:base0f = [ '#ab7967', 17 ]
else
    let s:base01 = [ '#a3be8c', 10 ]
    let s:base02 = [ '#ebcb8b', 11 ]
    let s:base04 = [ '#8fa1b3', 12 ]
    let s:base06 = [ '#b48ead', 13 ]
    let s:base09 = [ '#bf616a', 9 ]
    let s:base0f = [ '#96b5b4', 14 ]
endif
if &background ==# 'light'
    let [s:base03, s:base07] = [s:base07, s:base03]
    let [s:base02, s:base05] = [s:base05, s:base02]
    let [s:base01, s:base06] = [s:base06, s:base01]
    let [s:base00, s:base04] = [s:base04, s:base00]
endif
let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ [ s:base07, s:base0d ], [ s:base07, s:base02 ] ]
let s:p.normal.right = [ [ s:base02, s:base04 ], [ s:base06, s:base02 ] ]
let s:p.inactive.right = [ [ s:base02, s:base01 ], [ s:base00, s:base02 ] ]
let s:p.inactive.left =  [ [ s:base04, s:base02 ], [ s:base00, s:base02 ] ]
let s:p.insert.left = [ [ s:base07, s:base0b ], [ s:base07, s:base01 ] ]
let s:p.replace.left = [ [ s:base07, s:base08 ], [ s:base07, s:base01 ] ]
let s:p.visual.left = [ [ s:base07, s:base0e ], [ s:base07, s:base01 ] ]
let s:p.normal.middle = [ [ s:base03, s:base01 ] ]
let s:p.inactive.middle = [ [ s:base04, s:base01 ] ]
let s:p.tabline.left = [ [ s:base05, s:base01 ] ]
let s:p.tabline.tabsel = [ [ s:base05, s:base02 ] ]
let s:p.tabline.middle = [ [ s:base01, s:base05 ] ]
let s:p.tabline.right = copy(s:p.normal.right)
let s:p.normal.error = [ [ s:base05, s:base08 ] ]
let s:p.normal.warning = [ [ s:base02, s:base0a ] ]

let g:lightline#colorscheme#base16_ocean#palette = lightline#colorscheme#flatten(s:p)

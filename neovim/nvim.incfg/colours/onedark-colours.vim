" For joshdick/onedark.vim

set background=dark

let g:onedark_terminal_italics=1

let g:onedark_termcolors=256
" If terminal colours are properly set, replace above line with:
" let g:onedark_termcolors=16

colorscheme onedark
let g:airline_theme='onedark'

hi SpellBad cterm=underline ctermfg=9
hi SpellRare cterm=underline ctermfg=12
hi SpellLocal cterm=underline ctermfg=11
hi ColorColumn ctermbg=236

let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#4B4B4B'

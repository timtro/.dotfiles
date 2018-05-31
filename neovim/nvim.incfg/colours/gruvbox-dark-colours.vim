" For morhetz/gruvbox

set background=dark

let g:gruvbox_italic = 1
let g:gruvbox_bold = 1
let g:gruvbox_underline = 1
" let g:gruvbox_termcolors = 256
let g:gruvbox_contrast_dark = "hard"

colorscheme gruvbox
let g:airline_theme = "gruvbox"

runtime ./colours/palette.vim

exe "hi SpellBad cterm=underline ctermfg=9 guifg=".g:palette['gruv:ltRed']
exe "hi SpellRare cterm=underline ctermfg=12 guifg=".g:palette['gruv:ltBlue']
exe "hi SpellLocal cterm=underline ctermfg=11 guifg=".g:palette['gruv:ltYellow']
exe "hi ColorColumn ctermbg=236 guifg=".g:palette['gruv:bg1']

let g:indentLine_color_term = 236
let g:indentLine_color_gui = palette['gruv:bg_s']

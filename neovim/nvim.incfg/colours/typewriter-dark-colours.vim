
set background=dark

colorscheme typewriter-night
let g:airline_theme = "distinguished"

runtime ./colours/palette.vim

exe "hi SpellBad cterm=underline ctermfg=9 guifg=".g:palette['gruv:red']
exe "hi SpellRare cterm=underline ctermfg=12 guifg=".g:palette['gruv:blue']
exe "hi SpellLocal cterm=underline ctermfg=11 guifg=".g:palette['gruv:yellow']
exe "hi ColorColumn ctermbg=236 guifg=".g:palette['gruv:bg1']

let g:indentLine_color_term = 236
let g:indentLine_color_gui = g:palette['grey30']

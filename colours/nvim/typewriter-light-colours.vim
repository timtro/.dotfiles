
set background=light

colorscheme typewriter
let g:airline_theme = "typewriter"

source ~/.dotfiles/colours/nvim/palette.vim

exe "hi SpellBad cterm=underline ctermfg=9 guifg=".g:palette['gruv:red']
exe "hi SpellRare cterm=underline ctermfg=12 guifg=".g:palette['gruv:blue']
exe "hi SpellLocal cterm=underline ctermfg=11 guifg=".g:palette['gruv:yellow']
exe "hi ColorColumn ctermbg=236 guifg=".g:palette['gruv:bg1']
hi SignColumn ctermbg=254 guibg=#EEEE
hi! GitGutterAdd ctermbg=NONE guibg=NONE
hi! GitGutterChange ctermbg=NONE guibg=NONE
hi! GitGutterDelete ctermbg=NONE guibg=NONE
hi! GitGutterChangeDelete ctermbg=NONE guibg=NONE


let g:indentLine_color_term = 236
let g:indentLine_color_gui = g:palette['grey80']

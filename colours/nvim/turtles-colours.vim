" For beigebrucewayne/Turtles
"
" For klien/rainbow_parentheses. Doesn't work for junegunn/rainbow...
" augroup RainbowParens
"  au!
"  au VimEnter * RainbowParenthesesToggle
"  au Syntax * RainbowParenthesesLoadRound
"  au Syntax * RainbowParenthesesLoadSquare
"  au Syntax * RainbowParenthesesLoadBraces
" augroup END

colorscheme turtles
let g:airline_theme = "turtles"

hi SpellBad cterm=underline ctermfg=9
hi SpellRare cterm=underline ctermfg=12
hi SpellLocal cterm=underline ctermfg=11
hi ColorColumn ctermbg=236
hi ColorColumn guibg=#303030

let g:indentLine_color_term = 235
let g:indentLine_color_gui = '#262626'

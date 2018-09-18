
set background=dark

colorscheme Base2Tone_EveningDark
let g:airline_theme='Base2Tone_EveningDark'

" colorscheme Base2Tone_MorningDark
" let g:airline_theme='Base2Tone_MorningDark'

" colorscheme Base2Tone_SeaDark
" let g:airline_theme='Base2Tone_SeaDark'

" colorscheme Base2Tone_SpaceDark
" let g:airline_theme='Base2Tone_SpaceDark'

" colorscheme Base2Tone_EarthDark
" let g:airline_theme='Base2Tone_EarthDark'

" colorscheme Base2Tone_ForestDark
" let g:airline_theme='Base2Tone_ForestDark'

" colorscheme Base2Tone_DesertDark
" let g:airline_theme='Base2Tone_DesertDark'

" colorscheme Base2Tone_LakeDark
" let g:airline_theme='Base2Tone_LakeDark'

" colorscheme Base2Tone_MeadowDark
" let g:airline_theme='Base2Tone_MeadowDark'

" colorscheme Base2Tone_DrawbridgeDark
" let g:airline_theme='Base2Tone_DrawbridgeDark'

" colorscheme Base2Tone_PoolDark
" let g:airline_theme='Base2Tone_PoolDark'

" colorscheme Base2Tone_HeathDark
" let g:airline_theme='Base2Tone_HeathDark'

" colorscheme Base2Tone_CaveDark
" let g:airline_theme='Base2Tone_CaveDark'

source ~/.dotfiles/colours/nvim/palette.vim

exe "hi SpellBad cterm=underline ctermfg=9 guifg=".g:palette['gruv:ltRed']
exe "hi SpellRare cterm=underline ctermfg=12 guifg=".g:palette['gruv:ltBlue']
exe "hi SpellLocal cterm=underline ctermfg=11 guifg=".g:palette['gruv:ltYellow']
exe "hi ColorColumn ctermbg=236 guifg=".g:palette['gruv:bg1']

let g:indentLine_color_term = 236
let g:indentLine_color_gui = '#303030'

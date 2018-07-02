" For nightsense/vimspectr

let vimspectr_themes = [
 \  'vimspectr0-dark'
 \, 'vimspectr30-dark'
 \, 'vimspectr60-dark' 
 \, 'vimspectr90-dark'
 \, 'vimspectr120-dark'
 \, 'vimspectr150-dark'
 \, 'vimspectr180-dark'
 \, 'vimspectr210-dark'
 \, 'vimspectr240-dark'
 \, 'vimspectr270-dark'
 \, 'vimspectr300-dark'
 \, 'vimspectr330-dark'
 \, 'vimspectrgrey-dark'
 \ ]
" exe 'colorscheme '.vimspectr_themes[localtime() % len(vimspectr_themes)]

colorscheme vimspectr240-dark

let g:airline_theme = "powerlineish"

hi SpellBad cterm=underline ctermfg=9
hi SpellRare cterm=underline ctermfg=12
hi SpellLocal cterm=underline ctermfg=11
hi ColorColumn ctermbg=236

let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#4B4B4B'

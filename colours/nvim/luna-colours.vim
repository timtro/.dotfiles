
set background=dark

if exists('g:GtkGuiLoaded')
  colorscheme luna
else
  colorscheme luna-term
endif


hi SpellBad cterm=underline ctermfg=9
hi SpellRare cterm=underline ctermfg=12
hi SpellLocal cterm=underline ctermfg=11
hi ColorColumn ctermbg=236

let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#4B4B4B'

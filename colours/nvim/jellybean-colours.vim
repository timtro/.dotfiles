
set background=dark

let g:jellybeans_use_term_italics = 1

if !exists('g:GtkGuiLoaded')
  let g:jellybeans_overrides = {
  \      'background': { 'ctermbg': 'none', '256ctermbg': 'none' },
  \}
endif

colorscheme jellybeans

hi SpellBad cterm=underline ctermfg=9
hi SpellRare cterm=underline ctermfg=12
hi SpellLocal cterm=underline ctermfg=11
hi ColorColumn ctermbg=236

let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#4B4B4B'


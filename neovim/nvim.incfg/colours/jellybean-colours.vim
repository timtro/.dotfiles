
let g:jellybeans_use_term_italics = 1

if !exists('g:GtkGuiLoaded')
  let g:jellybeans_overrides = {
  \      'background': { 'ctermbg': 'none', '256ctermbg': 'none' },
  \}
endif

colorscheme jellybeans


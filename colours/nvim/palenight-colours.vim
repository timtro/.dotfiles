" For widatama/vim-phoenix

set background=dark

colorscheme palenight
let g:airline_theme = "palenight"

hi! SpellBad cterm=underline ctermfg=9 guifg=#FF0000
hi! SpellRare cterm=underline ctermfg=12
hi! SpellLocal cterm=underline ctermfg=11
hi! ColorColumn ctermbg=236

let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#4B4B4B'

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

let g:palenight_terminal_italics=1

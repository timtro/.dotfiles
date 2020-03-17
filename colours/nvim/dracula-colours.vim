
set background=dark

colorscheme dracula
let g:airline_theme = "dracula"

source ~/.dotfiles/colours/nvim/palette.vim

let g:indentLine_color_term = g:dracula#palette.bglighter[1]
let g:indentLine_color_gui = g:dracula#palette.bglighter[0]


set background=dark

let g:one_allow_italics = 1

colorscheme one
let g:airline_theme='one'

" let g:indentLine_color_term = 239
" let g:indentLine_color_gui = '#4B4B4B'

source ~/.dotfiles/colours/nvim/palette.vim

let g:rainbow_conf = {'guifgs':
\   [ g:palette['one:ltOrange']
\   , g:palette['one:green']
\   , g:palette['one:purple']
\   , g:palette['one:yellow']
\   , g:palette['one:blue']
\   , g:palette['one:cyan']
\   , g:palette['gruv:dkYellow']
\   , g:palette['one:dkOrange']
\   , g:palette['gruv:dkGreen']
\   , g:palette['gruv:dkOrange']
\   ]
\}

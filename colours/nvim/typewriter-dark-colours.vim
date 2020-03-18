
set background=dark

colorscheme typewriter-night
let g:airline_theme = "distinguished"

source ~/.dotfiles/colours/nvim/palette.vim

exe "hi SpellBad cterm=underline ctermfg=9 guifg=".g:palette['gruv:red']
exe "hi SpellRare cterm=underline ctermfg=12 guifg=".g:palette['gruv:blue']
exe "hi SpellLocal cterm=underline ctermfg=11 guifg=".g:palette['gruv:yellow']
exe "hi ColorColumn ctermbg=236 guifg=".g:palette['gruv:bg1']
hi SignColumn ctermbg=235 guibg=#262626

let g:indentLine_color_term = 236
let g:indentLine_color_gui = g:palette['grey30']

let g:rainbow_conf = {'guifgs':
\   [ g:palette['gruv:purple']
\   , g:palette['gruv:blue']
\   , g:palette['gruv:yellow']
\   , g:palette['gruv:green']
\   , g:palette['gruv:orange']
\   , g:palette['gruv:dkPurple']
\   , g:palette['gruv:dkBlue']
\   , g:palette['gruv:dkYellow']
\   , g:palette['gruv:dkGreen']
\   , g:palette['gruv:dkOrange']
\   ]
\}

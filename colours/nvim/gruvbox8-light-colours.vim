" For lifepillar/vim-gruvbox8

set background=light

let g:gruvbox_italics = 1
let g:gruvbox_italicize_strings = 1
let g:gruvbox_bold = 1
let g:gruvbox_underline = 1
let g:gruvbox_transp_bg = 0
let g:gruvbox_filetype_hi_groups = 1
let g:gruvbox_plugin_hi_groups = 1

colorscheme gruvbox8
let g:airline_theme = "gruvbox"

source ~/.dotfiles/colours/nvim/palette.vim

" exe "hi SpellBad cterm=underline ctermfg=9 guifg=".g:palette['gruv:ltRed']
" exe "hi SpellRare cterm=underline ctermfg=12 guifg=".g:palette['gruv:ltBlue']
" exe "hi SpellLocal cterm=underline ctermfg=11 guifg=".g:palette['gruv:ltYellow']
" exe "hi ColorColumn ctermbg=236 guifg=".g:palette['gruv:bg1']
" exe "hi Folded guibg=".g:palette['gruv:bg_h']

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

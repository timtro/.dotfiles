" For lifepillar/vim-gruvbox8

set background=dark

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

exe "hi Folded guibg=".g:palette['gruv:bg']
exe "hi SignColumn guibg=".g:palette['gruv:bg']
exe "hi CursorLineNr guibg=".g:palette['gruv:bg']
exe "hi GitGutter guibg=".g:palette['gruv:bg']
exe "hi GitGutterAdd guibg=".g:palette['gruv:bg']
exe "hi GitGutterChange guibg=".g:palette['gruv:bg']
exe "hi GitGutterDelete guibg=".g:palette['gruv:bg']
exe "hi GitGutterChangeDelete guibg=".g:palette['gruv:bg']

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

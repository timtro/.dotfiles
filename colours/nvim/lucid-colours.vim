" For: cseelus/vim-colors-lucid

set background=dark

colorscheme lucid

" let g:airline_theme = "lucid"

" very saturated grays
let _rock_dark   = '#0f0c14'
let _rock        = '#181320'
" normal grays
" --------------------------
let _rock_medium = '#36323d'
let _gray_dark   = '#534d5e'
let _gray        = '#847d91'
let _gray_medium = '#beb8cc'
let _gray_light  = '#d2c3ef'
let _cloud       = '#e4e0ed'
" colors
" --------------------------
let _turquoise   = '#3fc997'
let _fluoric     = '#d0ffc3'
let _cyan        = '#99feff'
let _steel       = '#83a8d1'
let _powder      = '#8fc7db'
let _purple      = '#7470ce'
let _sky         = '#b3e4eb'
let _pink        = '#db0088'
let _sap         = '#fde9a2'


exe "hi ColorColumn ctermbg=236 guibg="._rock
let g:indentLine_color_gui = _rock_medium

let g:rainbow#blacklist =
  \ [ _rock_dark
  \ , _rock
  \ , _rock_medium
  \ , _gray_dark
  \ , _gray
  \ , _gray_medium
  \ , _gray_light
  \ , _cloud
  \ ]


" exe "hi SpellBad cterm=underline ctermfg=9 guifg=".palette['gruv:red']
" exe "hi SpellRare cterm=underline ctermfg=12 guifg=".palette['gruv:blue']
" exe "hi SpellLocal cterm=underline ctermfg=11 guifg=".palette['gruv:yellow']
" hi SignColumn ctermbg=235 guibg=#262626

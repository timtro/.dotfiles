" FOR: https://github.com/lifepillar/vim-solarized8
" NOT For altercation/vim-colors-solarized

let g:airline_theme = "solarized"
set background=dark

let g:solarized_bold = 1
let g:solarized_underline = 1
let g:solarized_italic = 1
let g:solarized_term_italics = 1
let g:solarized_extra_hi_groups = 1
let g:solarized_termtrans = 0

colorscheme solarized8_high

let g:solarizedColours =
\ { 'fg': '#ebdbb2'
\ , 'bg': '#282828'
\ , 'red': '#dc322f'
\ , 'orange': '#dc322f'
\ , 'yellow': '#b58900'
\ , 'magenta': '#d33682'
\ , 'violet': '#6c71c4'
\ , 'blue': '#268bd2'
\ , 'cyan': '#2aa198'
\ , 'green': '#859900'
\ , 'base2': '#eee8d5'
\ , 'base3': '#fdf6e3'
\ , 'base1': '#93a1a1'
\ , 'base0': '#839496'
\ , 'base00': '#657b83'
\ , 'base01': '#586e75'
\ , 'base02': '#073642'
\ , 'base03': '#002b36'
\ }

exe "hi SpellBad cterm=underline ctermfg=9 guifg=".g:solarizedColours['red']
exe "hi SpellRare cterm=underline ctermfg=12 guifg=".g:solarizedColours['violet']
exe "hi SpellLocal cterm=underline ctermfg=11 guifg=".g:solarizedColours['yellow']
" exe "hi ColorColumn ctermbg=236 guifg=".g:solarizedColours['bg1']

let g:indentLine_color_gui = solarizedColours['base02']

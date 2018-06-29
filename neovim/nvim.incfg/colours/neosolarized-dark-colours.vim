" FOR: https://github.com/lifepillar/vim-solarized8
" NOT For altercation/vim-colors-solarized

set background=dark

" default value is "normal", Setting this option to "high" or "low" does use the
" same Solarized palette but simply shifts some values up or down in order to
" expand or compress the tonal range displayed.
let g:neosolarized_contrast = "normal"

" Special characters such as trailing whitespace, tabs, newlines, when displayed
" using ":set list" can be set to one of three levels depending on your needs.
" Default value is "normal". Provide "high" and "low" options.
let g:neosolarized_visibility = "normal"

" I make vertSplitBar a transparent background color. If you like the origin
" solarized vertSplitBar style more, set this value to 0.
let g:neosolarized_vertSplitBgTrans = 1

let g:neosolarized_bold = 1
let g:neosolarized_underline = 1
let g:neosolarized_italic = 1

colorscheme NeoSolarized

let g:airline_theme = "zenburn"
" let g:airline_theme = "luna"
" let g:airline_theme = "materialmonokai"
" let g:airline_theme = "serene"

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

" let g:indentLine_color_gui = solarizedColours['base02']

" For morhetz/gruvbox

set background=dark

" Gruvbox colours:
let g:gruvColours =
\ { 'fg': '#ebdbb2'
\ , 'bg': '#282828'
\ , 'dkRed': '#9d0006'
\ , 'red': '#cc241d'
\ , 'ltRed': '#fb4934'
\ , 'dkGreen': '#79740e'
\ , 'green': '#98971a'
\ , 'ltGreen': '#b8bb26'
\ , 'dkYellow': '#b57614'
\ , 'yellow': '#d79921'
\ , 'ltYellow': '#fabd2f'
\ , 'dkBlue': '#076678'
\ , 'blue': '#458588'
\ , 'ltBlue': '#83a598'
\ , 'dkPurple': '#8f3f71'
\ , 'purple': '#b16286'
\ , 'ltPurple': '#d3869b'
\ , 'dkCyan': '#427b58'
\ , 'cyan': '#689d6a'
\ , 'ltCyan': '#8ec07c'
\ , 'dkOrange': '#af3a03'
\ , 'orange': '#d65d0e'
\ , 'ltOrange': '#fe8019'
\ , 'ltGrey': '#a89984'
\ , 'bg_h': '#1d2021'
\ , 'bg_s': '#32302f'
\ , 'bg1': '#3c3836'
\ , 'bg2': '#504945'
\ , 'bg3': '#665c54'
\ , 'bg4': '#7c6f64'
\ , 'fg0': '#fbf1c7'
\ , 'fg1': '#ebdbb2'
\ , 'fg2': '#d5c4a1'
\ , 'fg3': '#bdae93'
\ , 'fg4': '#a89984'}


let g:gruvbox_italic = 1
let g:gruvbox_bold = 1
let g:gruvbox_underline = 1
" let g:gruvbox_termcolors = 256
let g:gruvbox_contrast_dark = "hard"

colorscheme gruvbox
let g:airline_theme = "gruvbox"

exe "hi SpellBad cterm=underline ctermfg=9 guifg=".g:gruvColours['ltRed']
exe "hi SpellRare cterm=underline ctermfg=12 guifg=".g:gruvColours['ltBlue']
exe "hi SpellLocal cterm=underline ctermfg=11 guifg=".g:gruvColours['ltYellow']
exe "hi ColorColumn ctermbg=236 guifg=".g:gruvColours['bg1']

let g:indentLine_color_term = 236
let g:indentLine_color_gui = gruvColours['bg_s']

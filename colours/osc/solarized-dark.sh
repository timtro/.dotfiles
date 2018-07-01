#! /bin/bash

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $dir/colourtools.sh

set_term_curzor "#fb4934"
set_term_fg "#839496"
set_term_bg "#002b36"

# Black + DarkGrey
cset 0 "#073642"
cset 8 "#002b36"
# DarkRed + Red
cset 1  "#dc322f"
cset 9  "#cb4b16"
# DarkGreen + Green
cset 2  "#859900"
cset 10 "#586e75"
# DarkYellow + Yellow
cset 3  "#b58900"
cset 11 "#657b83"
# DarkBlue + Blue
cset 4  "#268bd2"
cset 12 "#839496"
# DarkMagenta + Magenta
cset 5  "#d33682"
cset 13 "#6c71c4"
# DarkCyan + Cyan
cset 6  "#2aa198"
cset 14 "#93a1a1"
# LightGrey + White
cset 7  "#eee8d5"
cset 15 "#fdf6e3"

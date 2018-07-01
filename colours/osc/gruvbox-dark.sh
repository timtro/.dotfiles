#! /bin/bash

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $dir/colourtools.sh

set_term_bg "#1d2021"
set_term_fg "#ebdbb2"
set_term_cursor "#fb4934"

# Black + DarkGrey
cset 0 "#282828"
cset 8 "#928374"
# DarkRed + Red
cset 1  "#cc241d"
cset 9  "#fb4934"
# DarkGreen + Green
cset 2  "#98971a"
cset 10 "#b8bb26"
# DarkYellow + Yellow
cset 3  "#d79921"
cset 11 "#fabd2f"
# DarkBlue + Blue
cset 4  "#458588"
cset 12 "#83a598"
# DarkMagenta + Magenta
cset 5  "#b16286"
cset 13 "#d3869b"
# DarkCyan + Cyan
cset 6  "#689d6a"
cset 14 "#8ec07c"
# LightGrey + White
cset 7  "#a89984"
cset 15 "#ebdbb2"

#! /bin/bash

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $dir/colourtools.sh

# hard contrast: *background: #1d2021
#*background: #282828
#! soft contrast: *background: #32302f
#*foreground: #ebdbb2
#*cursorColor: #fb4934

# Black + DarkGrey
cset 0 "28/28/28"
cset 8  "92/83/74"
# DarkRed + Red
cset 1  "cc/24/1d"
cset 9  "fb/49/34"
# DarkGreen + Green
cset 2  "98/97/1a"
cset 10 "b8/bb/26"
# DarkYellow + Yellow
cset 3  "d7/99/21"
cset 11 "fa/bd/2f"
# DarkBlue + Blue
cset 4  "45/85/88"
cset 12 "83/a5/98"
# DarkMagenta + Magenta
cset 5  "b1/62/86"
cset 13 "d3/86/9b"
# DarkCyan + Cyan
cset 6  "68/9d/6a"
cset 14 "8e/c0/7c"
# LightGrey + White
cset 7  "a8/99/84"
cset 15 "eb/db/b2"

#! /bin/bash

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $dir/colourtools.sh

# hard contrast: *background: #1d2021
#*background: #282828
#! soft contrast: *background: #32302f
#*foreground: #ebdbb2
#*cursorColor: #fb4934

# Black + DarkGrey
cset 0 "07/36/42"
cset 8 "00/2b/36"
# DarkRed + Red
cset 1  "dc/32/2f"
cset 9  "cb/4b/16"
# DarkGreen + Green
cset 2  "85/99/00"
cset 10 "58/6e/75"
# DarkYellow + Yellow
cset 3  "b5/89/00"
cset 11 "65/7b/83"
# DarkBlue + Blue
cset 4  "26/8b/d2"
cset 12 "83/94/96"
# DarkMagenta + Magenta
cset 5  "d3/36/82"
cset 13 "6c/71/c4"
# DarkCyan + Cyan
cset 6  "2a/a1/98"
cset 14 "93/a1/a1"
# LightGrey + White
cset 7  "ee/e8/d5"
cset 15 "fd/f6/e3"

kitty @ set-colors -a cursor="#fb4934" foreground="#839496" background="#002b36"

#! /bin/bash

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $dir/colourtools.sh

# special
# set_term_fg "#ffffff"
# set_term_bg "#141414"
set_term_cursor "#e33962"

# black
# cset 0 "#000000"
# cset 8 "#70736d"

# red
cset 1 "#a92a49"
cset 9 "#e33962"

# green
cset 2 "#8ab544"
cset 10 "#a7e346"

# yellow
cset 3 "#f39a26"
cset 11 "#f1c58b"

# blue
cset 4 "#518ba3"
cset 12 "#73b9d6"

# magenta
cset 5 "#9770b3"
cset 13 "#c598e6"

# cyan
cset 6 "#5ba6a5"
cset 14 "#82d9d8"

# white
# cset 7 "#d3d7cf"
# cset 15 "#eeeeec"

#! /bin/bash

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $dir/colourtools.sh

# special
set_term_fg "#c0caf5"
# set_term_bg "#1a1b26"
# Each channel decremented because of transparency issue with nvim
set_term_bg "#191a25"
set_term_cursor "#e33962"

# black
cset 0 "#1D202F"
cset 8 "#414868"

scalef=1.3

# red
cset 1 "#f7768e"
cset 9 $(scale "#f7768e" $scalef)

# green
cset 2 "#9ece6a"
cset 10 $(scale "#9ece6a" $scalef)

# yellow
cset 3 "#e0af68"
cset 11 $(scale "#e0af68" $scalef)

# blue
cset 4 "#7aa2f7"
cset 12 $(scale "#7aa2f7" $scalef)

# magenta
cset 5 "#bb9af7"
cset 13 $(scale "#bb9af7" $scalef)

# cyan
cset 6 "#7dcfff"
cset 14 $(scale "#7dcfff" $scalef)

# white
cset 7 "#a9b1d6"
cset 15 "#c0caf5"

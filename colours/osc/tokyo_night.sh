#! /bin/bash

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $dir/colourtools.sh

# special
set_term_fg "#c0caf5"
set_term_bg "#24283b"
set_term_cursor "#e33962"

# black
cset 0 "#1D202F"
cset 8 "#414868"

# red
cset 1 "#f7768e"
cset 9 "#f7768e"

# green
cset 2 "#9ece6a"
cset 10 "#9ece6a"

# yellow
cset 3 "#e0af68"
cset 11 "#e0af68"

# blue
cset 4 "#7aa2f7"
cset 12 "#7aa2f7"

# magenta
cset 5 "#bb9af7"
cset 13 "#bb9af7"

# cyan
cset 6 "#7dcfff"
cset 14 "#7dcfff"

# white
cset 7 "#a9b1d6"
cset 15 "#c0caf5"

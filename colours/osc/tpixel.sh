#! /bin/bash

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $dir/colourtools.sh

# special
# *.foreground:   #ffffff
# *.background:   #141414
# *.cursorColor:  #e33962

# black
cset 0 "00/00/00"
cset 8 "70/73/6d"

# red
cset 1 "a9/2a/49"
cset 9 "e3/39/62"

# green
cset 2 "8a/b5/44"
cset 10 "a7/e3/46"

# yellow
cset 3 "f3/9a/26"
cset 11 "f1/c5/8b"

# blue
cset 4 "51/8b/a3"
cset 12 "73/b9/d6"

# magenta
cset 5 "97/70/b3"
cset 13 "c5/98/e6"

# cyan
cset 6 "5b/a6/a5"
cset 14 "82/d9/d8"

# white
cset 7 "d3/d7/cf"
cset 15 "ee/ee/ec"

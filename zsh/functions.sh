
function print_greeting {
  echo "\n"
  artfolder=$HOME/.dotfiles/zsh/art
  art=$(find "$artfolder" -type f -iname "*.txt" | sort -R | tail -1)
  cat $art

  # artfolder=$HOME/.dotfiles/neofetch/art
  # art=$(find "$artfolder" -type f -iname "*.txt" | sort -R | tail -1)
  # neofetch --config ~/.dotfiles/neofetch/config --ascii "$art"
  echo "\n"
}

function run_detached {
  echo "Running $@"
  nohup $@ >/dev/null 2>&1 &
  disown
}

function term_size {
  echo \(`tput cols` x `tput lines`\)
}

function svg2png {
  inkscape --export-png=$2 --export-dpi=300 --export-background-opacity=0 --without-gui $1
}

function term_fonts_test {
  echo -e "\e[1mbold\e[0m"
  echo -e "\e[3mitalic\e[0m"
  echo -e "\e[1m\e[3mBolditalic\e[0m"
  echo -e "\e[4munderline\e[0m"
  echo -e "\e[9mstrikethrough\e[0m"
  echo -e "\e[31mRed\e[0m"
  echo -e "\x1B[31mHello World\e[0m"
}

function ansi { echo -e "\e[${1}m${*:2}\e[0m"; }
function bold { ansi 1 "$@"; }
function italic { ansi 3 "$@"; }
function underline { ansi 4 "$@"; }
function strikethrough { ansi 9 "$@"; }
function red { ansi 31 "$@"; }

## Git related
# Some borrowed from https://stackoverflow.com/a/2658301/1827360

# Returns "*" if the current git branch is dirty.
function is_git_dirty {
  [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo "*"
}


function is_git_num_untracked_files {
  expr `git status --porcelain 2>/dev/null| grep "^??" | wc -l`
}

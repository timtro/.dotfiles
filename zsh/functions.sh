
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

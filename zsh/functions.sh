#!/usr/bin/zsh

PROGNAME=$0

function raise_error {
  echo "${PROGNAME}: 😕… ${1:-"Unknown Error"}" 1>&2
}

function print_greeting {
  echo "\n"
  artfolder=$HOME/.dotfiles/zsh/art

  if [[ "$HOST" == "johnny5" ]]; then
    art="$artfolder/johnny-5-head.ansi.txt"
  elif [[ "$HOST" == "qubit" ]]; then
    # art="$artfolder/pacman.txt"
    art=$(find "$artfolder" -type f -iname "*.txt" | sort -R | tail -1)
  else
    art=$(find "$artfolder" -type f -iname "*.txt" | sort -R | tail -1)
  fi

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

function seepdf {
  zathura $1 & disown
}

# Tablet
function wacom_on_primary_screen {
  primary_screen_geometry=`xrandr | grep "primary" | awk '{print $4}'`
  for i in `xsetwacom --list | awk '{print $8}'`; do
    xsetwacom set $i MapToOutput ${primary_screen_geometry}
  done
}

function wacom_presentkeys {
  #Four keys above ring:
  xsetwacom --set "Wacom Intuos Pro L Pad pad" Button 2 key '+Control_L +r'
  xsetwacom --set "Wacom Intuos Pro L Pad pad" Button 3 key '+Control_L +space'
  xsetwacom --set "Wacom Intuos Pro L Pad pad" Button 8 key '+Control_L +s'
  # xsetwacom --set "Wacom Intuos Pro L Pad pad" Button 9 key '+Page_Down'
  # Ring ()
  # Four keys below ring:
  xsetwacom --set "Wacom Intuos Pro L Pad pad" Button 10 key '+Control_L +z'
  xsetwacom --set "Wacom Intuos Pro L Pad pad" Button 11 key '+Control_L +y'
  xsetwacom --set "Wacom Intuos Pro L Pad pad" Button 12 key '+Page_Up'
  xsetwacom --set "Wacom Intuos Pro L Pad pad" Button 13 key '+Page_Down'
}

function wacom_setup {
  wacom_on_primary_screen
  wacom_presentkeys
}

function compose_search {
  local locale=`locale | awk -F"=" '/LANG/{print $2}'`
  local composeKeysFileCmd='cat "/usr/share/X11/locale/compose.dir" | grep $locale | tail -n1 | awk '"'"'{print $1}'"'"' | sed s'"'"'/.$//'"'"
  local composeKeysFile=/usr/share/X11/locale/`eval $composeKeysFileCmd`

  if [[ "$1" == "ALL" ]]; then
    less "$composeKeysFile"
  else
    grep $1 "$composeKeysFile"
    if [[ -e "$HOME/.XCompose" ]]; then
      echo "\nIn user .XCompose:\n\n"
      grep $1 "$HOME/.XCompose"
    fi
  fi
}

## Git related
# Some borrowed from https://stackoverflow.com/a/2658301/1827360

# Returns "*" if the current git branch is dirty.
function is_git_dirty {
  [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo "*"
}

function is_git_num_untracked_files {
  expr `git status --porcelain 2>/dev/null| grep "^??" | wc -l`
}

function edit_in {
  if [[ $EDITOR == "nvim" ]]; then
    nvim +"lcd $1" $2
  else
    raise_error "“\$EDITOR=$EDITOR, and I don't know how to set a working directory with that”"
  fi
}

function is_running {
  return `pidof -x "$1" >/dev/null`
}

function start_uniquely {
  if is_running $1; then
    notify-send -t 1000 "Process \"$1\" already running." &
  else
    $@ &
  fi
}

function load_module_uniquely {
  if lsmod | grep "$1" &> /dev/null ; then
    echo "Module $1 aldready running"
  else
    echo "Loading module \"$1\"."
    sudo modprobe $1 $2
  fi
}

function reload_module {
  if lsmod | grep "$1" &> /dev/null ; then
    echo "Module $1 aldready running, unmounting…"
    sudo modprobe -r $1
  fi
  echo "Loading module \"$1\"."
  sudo modprobe $*
}

function cast_android {
  reload_module v4l2loopback \
      devices=2 \
      video_nr=9,10 \
      card_label="OBS Video Source","Android Video Source" \
      exclusive_caps=1
  start_uniquely scrcpy --v4l2-sink /dev/video10 --no-display --max-size 1920
}

function uncast_android {
  sudo modprobe -r v4l2loopback
  killall scrcpy
}

function run_gl {
  if system76-power graphics &> /dev/null ; then
    graphics=`system76-power graphics`
    if [ "$grapics" != "hybrid" ] ; then
      printf '%s' "ERROR: graphics mode is currently set to '$graphics', but"
      printf ' %s\n' "this command requires graphics set to 'hybrid'."
    else
      __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia $1
    fi
  else
    echo "ERROR: command requires system76-power in path"
  fi
}

function check-wan {
  curl --http0.9 -s http://192.168.1.1/admin/landingpage.fwd \
    | html2text \
    | awk -f $HOME/.dotfiles/zsh/scr/router-stats.awk
}

function watch-wan {
  watch -d --color -x zsh -c check-wan
}

function watch-gateway {
  watch -d --color "curl --http0.9 -s http://192.168.1.1/admin/landingpage.fwd \
    | html2text"
}

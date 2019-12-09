#! /bin/bash

host=`uname -n`

echo "HOME: " $HOME

function main {
  if [[ "$host" == "johnny5" || "$host" == "qubit" ]]; then
    /home/timtro/.screenlayout/default.sh
    stalonetray_cfg="$HOME/.dotfiles/stalonetray/stalonetrayrc.2HD"
  elif [[ "$host" == "photon" ]]; then
    xinput set-prop 15 299 1 # Enable tap-to-click
    stalonetray_cfg="$HOME/.dotfiles/stalonetray/stalonetrayrc.HD"
  elif [[ "$host" == "positron" ]]; then
    stalonetray_cfg="$HOME/.dotfiles/stalonetray/stalonetrayrc.UHD"
    xinput --set-prop 15 302 1 # Enable tap to click
    xinput --set-prop 16 322 0.7 # Set trackpoint speed
    xinput --set-prop 15 322 .75 # Set touchpad speed
  else
    notify-send "WARNING: Tim, your custom Xmonad script doesn't know this host: '$host'."
  fi

  start_uniquely compton
  start_uniquely stalonetray -c "$stalonetray_cfg"
  start_uniquely insync start
  start_uniquely variety
  start_uniquely pnmixer
  start_uniquely nm-applet
  start_uniquely blueman-applet
  start_printer_applet
}

function start_uniquely {
  if is_running $1; then
    notify-send -t 1000 "Process \"$1\" already running." &
  else
    $@ &
  fi
}

function start_printer_applet {
  if is_running "applet.py"; then
    notify-send -t 1000 "Printer applet already running."
  else
    system-config-printer-applet
  fi
}

function is_running {
  return `pidof -x "$1" >/dev/null`
}

main

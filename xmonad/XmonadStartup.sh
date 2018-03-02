#! /bin/bash

host=`uname -n`

echo "HOME: " $HOME

function main {
  if [[ "$host" == "johnny-five" || "$HOST" == "qubit" ]]; then
    /home/timtro/.screenlayout/default.sh
    stalonetray_cfg="$HOME/.dotfiles/stalonetray/stalonetrayrc.2HD"
  elif [[ "$host" == "photon" ]]; then
    xinput set-prop 12 280 1 # Enable tap-to-click
    stalonetray_cfg="$HOME/.dotfiles/stalonetray/stalonetrayrc.HD"
  else
    notify-send "WARNING: Tim, your custom Xmonad script doesn't know this host: '$host'."
  fi

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
    notify-send "Process \"$1\" already running." &
  else
    $@ &
  fi
}

function start_printer_applet {
  if is_running "applet.py"; then
    notify-send "Printer applet already running."
  else
    system-config-printer-applet
  fi
}

function is_running {
  return `pidof -x "$1" >/dev/null`
}

main

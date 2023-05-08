#!/usr/bin/env bash

if xrandr -q | grep -Fq "eDP-1"
then
    laptop_screen="eDP-1"
else
    laptop_screen="HDMI-1"
fi

external_screen=$(xrandr -q \
                    | grep " connected" \
                    | awk '{print $1}' \
                    | grep -v $laptop_screen)

if [ -n "$external_screen" ]; then
  xrandr  --output $laptop_screen --auto --primary \
          --output $external_screen --auto --right-of $laptop_screen
else
  xrandr  --output $laptop_screen --auto \
          --output eDP1 --auto \
          --output HDMI-1 --auto
fi

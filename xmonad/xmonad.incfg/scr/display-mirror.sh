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
  xrandr --output $laptop_screen --mode 1920x1080 \
         --output $external_screen --mode 1920x1080 \
         --same-as $laptop_screen
else
  xrandr --output $laptop_screen --auto \
         --output eDP-1 --auto \
         --output HDMI-1 --auto
fi

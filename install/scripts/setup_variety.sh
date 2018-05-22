#! /bin/bash

if [ -f $HOME/.config/variety ]; then
  ln -s $HOME/.dotfiles/variety/* $HOME/.config/variety/scripts/.
else
  echo "  ERR: Variety not installed"
  exit 0
fi

#! /bin/bash

if [ -f $HOME/.config/variety ]; then
  ln -s $HOME/.dotfiles/variety/* $HOME/.config/variety/scripts/.
else
  mkdir --parents $HOME/.config/variety/scripts
  ln -s $HOME/.dotfiles/variety/* $HOME/.config/variety/scripts/.
fi

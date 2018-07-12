#! /bin/bash

# Pywal and compatible backends:
pip3 install pywal --user
pip3 install haishoku --user
pip3 install colorz --user
pip3 install colorthief --user

if [ -f $HOME/.config/variety ]; then
  ln -s $HOME/.dotfiles/variety/* $HOME/.config/variety/scripts/.
else
  mkdir --parents $HOME/.config/variety/scripts
  ln -s $HOME/.dotfiles/variety/* $HOME/.config/variety/scripts/.
fi

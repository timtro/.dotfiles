#!/bin/bash

cd ~/.dotfiles/neovim/nvim.incfg/bundle/YouCompleteMe/
./install.py --clang-completer


cd ~/.dotfiles/neovim/nvim.incfg/bundle/vimproc.vim
./make

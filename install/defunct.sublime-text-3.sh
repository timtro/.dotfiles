#!/bin/bash

echo -e "\nInstalling Sublime-text-3 plugins and settings"
echo "=============================="

dotFiles="$HOME/.dotfiles"

sublimeConfigDir="$HOME/.config/sublime-text-3"

if [ ! -d $sublimeConfigDir ]; then
  mkdir $sublimeConfigDir
fi

subDirs=$(find $dotFiles/sublime-text-3/ -mindepth 1 -maxdepth 1 -type d -regex ".*")

IFS=$'\n'
for dir in $subDirs; do
  target=$sublimeConfigDir/$( basename $dir )
  if [ -e $target ]; then
    echo "$dir already exists... Skipping."
  else
    echo "Creating symlink for $target"
    ln -s $dir $target
  fi
done

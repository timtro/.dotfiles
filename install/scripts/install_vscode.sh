#! /bin/bash

wget --content-disposition "https://go.microsoft.com/fwlink/?LinkID=760868"
  sudo dpkg -i code_*_amd64.deb
  sudo apt-get install -f
rm code_*_amd64.deb

code --install-extension Shan.code-settings-sync

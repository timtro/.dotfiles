#! /bin/bash
sudo systemctl stop mpd
sudo systemctl disable mpd
sudo systemctl stop mpd.socket
sudo systemctl disable mpd.socket

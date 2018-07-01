#! /bin/bash

function cset() {
  ANSI=$1
  RGB=$2 # In HTML hex format: #XXXXXX
  printf "\x1b]4;$ANSI;${RGB}\a"
}

function set_term_fg() {
  RGB=$1
  printf "\x1b]10;${RGB}\a"
}

function set_term_bg() {
  RGB=$1
  printf "\x1b]11;${RGB}\a"
}

function set_term_cursor() {
  RGB=$1
  printf "\x1b]12;${RGB}\a"
}

function cset_rgb() {
  ANSI=$1
  RGB=$2 # Hex with slashes: XX/XX/XX
  printf "\x1b]4;$ANSI;rgb:${RGB}\a"
}

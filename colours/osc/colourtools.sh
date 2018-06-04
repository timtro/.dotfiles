#! /bin/bash

function cset() {
  ANSI=$1
  RGB=$2
  printf "\x1b]4;$ANSI;rgb:${RGB}\a"
}

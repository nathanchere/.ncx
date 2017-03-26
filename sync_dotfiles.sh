#!/bin/bash

. "./_.sh"

doStowDots() {
  doStow "$1" dotfiles $HOME
}

main() {

  echo "Fixing bin script permissions"
  chmod a+rx dotfiles/utils/bin/*

  for DOTS in "$NCXROOT/dotfiles/"*; do
    DOTNAME=$(basename "$DOTS")
    doStowDots "$DOTNAME"
  done
}

main 2>&1 |& tee -a "$LOGFILE"

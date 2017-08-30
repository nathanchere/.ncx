#!/bin/bash

. "./_.sh"

requireNotRoot

doStowDots() {
  doStow "$1" dotfiles $HOME
}

main() {

  echo "Fixing general permissions"
  chmod a+r -R dotfiles/

  echo "Fixing bin script permissions"
  chmod a+rx dotfiles/bin/bin/*

  for DOTS in "$NCXROOT/dotfiles/"*; do
    DOTNAME=$(basename "$DOTS")
    doStowDots "$DOTNAME"
  done
}

main 2>&1 |& tee -a "$LOGFILE"

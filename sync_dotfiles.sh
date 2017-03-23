#!/bin/bash

. "./_.sh"

doStowDots() {
  doStow "$1" dotfiles $HOME
}

main() {
  doStowDots fish

  echo "Fixing bin script permissions"
  chmod a+rx dotfiles/utils/bin/*
  doStowDots utils

  doStowDots xmonad
  doStowDots terminator
  doStowDots git

  doStowDots compton
  doStowDots dunst
  doStowDots polybar

  doStowDots atom

  doStowDots htop
}

main 2>&1 |& tee -a "$LOGFILE"

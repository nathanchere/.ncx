#!/bin/bash
. _.sh

doStowDots() {
  doStow "$1" dotfiles ~
}

main() {
  doStowDots fish
  doStowDots xmonad
  doStowDots terminator

  doStowDots compton
  doStowDots dunst
  doStowDots polybar

  doStowDots atom

  doStowDots misc
}

main 2>&1 |& tee -a "$LOGFILE"

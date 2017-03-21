#!/bin/bash
. _.sh

doStowDots() {
  doStow "$1" dotfiles ~
}

main() {

  doStowDots xmonad
  doStowDots terminator
  doStowDots git

  doStowDots compton
  doStowDots dunst
  doStowDots polybar

  doStowDots atom

  doStowDots htop

  doStowDots misc
}

main 2>&1 |& tee -a "$LOGFILE"

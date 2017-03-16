#!/bin/bash
. _.sh

doStowDots() {
  doStow $1 dotfiles ~
}

main() {
  doStowDots atom
  doStowDots compton
  doStowDots polybar
  doStowDots terminator
  doStowDots vivaldi
  doStowDots xmonad
}

main 2>&1 |& tee -a $LOGFILE

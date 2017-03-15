#!/bin/bash
. _.sh

main() {
  doStow compton dotfiles ~
  doStow polybar dotfiles ~
  doStow terminator dotfiles ~
  doStow xmonad dotfiles ~
}

main 2>&1 |& tee -a $LOGFILE

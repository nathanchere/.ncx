#!/bin/bash
. _.sh

stowDots() {
  drawSubhead "Cleaning up existing $1 files"
  stow --verbose=2 -D -d dotfiles -t ~ $1  
  drawSubhead "Stowing $1"
  stow --verbose=2 -d dotfiles -t ~ $1
}

main() {
  stowDots compton
  stowDots polybar
  stowDots terminator
  stowDots xmonad
}

main 2>&1 |& tee -a $LOGFILE

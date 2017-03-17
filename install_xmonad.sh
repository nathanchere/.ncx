#!/bin/bash

. _.sh

main() {
  drawSubhead "Installing xmonad"
  sudo dnf install xmonad ghc-xmonad-contrib ghc-xmonad-devel ghc-xmonad-contrib-devel
}

main 2>&1 |& tee -a "$LOGFILE"

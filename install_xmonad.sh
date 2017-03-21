#!/bin/bash

. _.sh

requireRoot

main() {
  drawSubhead "Installing xmonad"
  dnf install xmonad ghc-xmonad-contrib ghc-xmonad-devel ghc-xmonad-contrib-devel
}

main 2>&1 |& tee -a "$LOGFILE"

#!/bin/bash
. _.sh

main() {
  drawSubhead "Symlinking font files"
  doStow fonts resources ~

  drawSubhead "Updating system font cache"
  fc-cache -fv
}

main 2>&1 |& tee -a "$LOGFILE"

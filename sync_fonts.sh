#!/bin/bash

. "./_.sh"

main() {
  drawSubhead "Fixing font permissions"
  chmod a+r -R ./fonts/

  drawSubhead "Copying font files"
  rsync -avm fonts/. "$HOME/.local/share/fonts"

  drawSubhead "Updating system font cache"
  fc-cache -fv
}

main 2>&1 |& tee -a "$LOGFILE"

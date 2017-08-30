#!/bin/bash

. "./_.sh"

main() {
  drawSubhead "Fixing resource permissions"
  chmod a+r -R ./resources/

  drawSubhead "Copying font files"
  rsync -avm resources/fonts/. "$HOME/.local/share/fonts"

  drawSubhead "Updating system font cache"
  fc-cache -fv > /devl/null  
}

main 2>&1 |& tee -a "$LOGFILE"

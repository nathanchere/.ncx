#!/bin/bash

. "./_.sh"

requireRoot

main() {
  dnf install -y fish
  
  INSTALLER="$TMPROOT/ohmy.fish"
  curl -L https://get.oh-my.fish > "$INSTALLER"
  /usr/bin/fish "$INSTALLER" --path="$HOME/.local/share/omf" --config="$HOME/.config/omf"
}

main 2>&1 |& tee -a "$LOGFILE"

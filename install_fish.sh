#!/bin/bash

. "./_.sh"

requireRoot

main() {
  dnf install -y fish

  OMFPATH="$HOME/.local/share/omf"

  if [! -d "$OMFPATH" [; then
    INSTALLER="$TMPROOT/ohmy.fish"
    curl -L https://get.oh-my.fish > "$INSTALLER"
    /usr/bin/fish "$INSTALLER" --path="$OMFPATH" --config="$HOME/.config/omf"
  else
    echo "OhMyFish already installed; skipping..."
  fi

  chmod a+rw -R "$OMFPATH"

  rm -f "$HOME/.fishrc"
  rm -rf "$HOME/.config/fish"
  rm -rf "$HOME/.config/omf"

  doStow fish dotfiles "$HOME"

  echo "Don't forget to chsh to set fish as your default shell"
}

main 2>&1 |& tee -a "$LOGFILE"

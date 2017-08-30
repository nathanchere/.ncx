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

  drawSubhead "Restoring OhMyFish bundles"
  echo "omf install" | fish

  drawSubhead "Don't forget to `chsh -s /usr/bin/fish` if you want fish as default"
  chsh -s /bin/bash
}

main 2>&1 |& tee -a "$LOGFILE"

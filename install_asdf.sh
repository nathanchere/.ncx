#!/bin/bash

. "./_.sh"

requireRoot

ASDFPATH="$HOME/.asdf"
ASDFBIN="$ASDFPATH/bin/asdf"

installAsdf() {
  if [ ! -d "$ASDFPATH" ]; then
    git clone https://github.com/asdf-vm/asdf.git "$ASDFPATH"
    cd "$ASDFPATH"
  else
    echo "asdf already installed"
    cd "$ASDFPATH"
    git fetch
  fi
  currentRelease=$(git describe --tags `git rev-list --tags --max-count=1`)
  git checkout "$currentRelease"

  chmod a+rwx -R "$ASDFPATH"
}

main() {
  installAsdf
}

main 2>&1 |& tee -a "$LOGFILE"

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

  cd -
}

main() {

  installAsdf

  drawSubhead "Installing Elixir stuff"
  dnf install -y erlang
  . "./install.elixir.sh"

  drawSubhead "Installing Ruby stuff"
  dnf install -y ruby gem

  drawHead "Installing Python stuff"
  #curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
  #pyenv update # TODO: add to fish, not just bash
}

main 2>&1 |& tee -a "$LOGFILE"

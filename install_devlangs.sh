#!/bin/bash

. "./_.sh"

requireRoot

main() {
  drawSubhead "Installing Elixir stuff"
  dnf install -y erlang
  . "./install.elixir.sh"

  drawSubhead "Installing Ruby stuff"
  dnf install -y ruby gem

  drawHead "Installing Python stuff"
  curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
  pyenv update # TODO: add to fish, not just bash
}

main 2>&1 |& tee -a "$LOGFILE"
yellow fever if you are gonna get sick in thatland that the thig to ahve

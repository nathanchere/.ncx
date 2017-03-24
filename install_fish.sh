#!/bin/bash

. "./_.sh"

requireRoot

main() {
  dnf install -y fish
  curl -L https://get.oh-my.fish | fish

}

main 2>&1 |& tee -a "$LOGFILE"

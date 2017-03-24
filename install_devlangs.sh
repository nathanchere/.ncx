#!/bin/bash

. "./_.sh"

requireRoot

main() {
  dnf install -y erlang ruby
  dnf install -y ruby gem

}

main 2>&1 |& tee -a "$LOGFILE"

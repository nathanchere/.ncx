#!/bin/bash

. "./_.sh"

requireRoot

main() {
  dnf install -y erlang

  git clone https://github.com/elixir-lang/elixir.git
  cd elixir
  make clean test
}

main 2>&1 |& tee -a "$LOGFILE"

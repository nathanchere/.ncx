#!/bin/bash

. "./_.sh"

requireNotRoot

main() {
  tempDir=`mktemp -d`

  git clone git@github.com:nathanchere/stx.git "$tempDir"
  cd "$x"
  make
  sudo make install
  rm -rf "$x"
}

main 2>&1 |& tee -a "$LOGFILE"

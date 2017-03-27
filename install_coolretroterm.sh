#!/bin/bash

. "./_.sh"

requireRoot

main() {
  dnf install -y qt5-qtbase qt5-qtbase-devel qt5-qtdeclarative qt5-qtdeclarative-devel qt5-qtgraphicaleffects qt5-qtquickcontrols redhat-rpm-config

  INSTALLDIR="$TMPROOT/crt"
  rm -rf "$INSTALLDIR"
  git clone --recursive https://github.com/Swordfish90/cool-retro-term.git "$INSTALLDIR"

  cd "$INSTALLDIR"
  qmake-qt5
  make
  make install
}

main 2>&1 |& tee -a "$LOGFILE"

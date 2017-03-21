#!/bin/bash
. _.sh

requireRoot

main() {
  dnf install -y automake autoconf readline-devel ncurses-devel openssl-devel
  dnf install -y libyaml-devel libxslt-devel libfft-devel libtool unixODBC-devel
  dnf install -y lshw
  dnf install -y feh i3lock scrot ImageMagick
  dnf install -y tint2
  dnf install -y htop lynx
  dnf install -y figlet
  dnf install -y docker
}

main 2>&1 |& tee -a "$LOGFILE"

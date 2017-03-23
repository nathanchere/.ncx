#!/bin/bash
. _.sh

requireRoot

main() {
  dnf copr enable konimex/neofetch
  dnf install -y automake autoconf readline-devel ncurses-devel openssl-devel
  dnf install -y libyaml-devel libxslt-devel libfft-devel libtool unixODBC-devel
  dnf install -y gem
  dnf install -y lshw nmap
  dnf install -y feh i3lock scrot ImageMagick
  dnf install -y tint2
  dnf install -y htop neofetch
  dnf install -y lynx
  dnf install -y figlet ddate
  dnf install -y docker
}

main 2>&1 |& tee -a "$LOGFILE"

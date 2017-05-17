#!/bin/bash

. "./_.sh"

requireRoot

main() {
  dnf install -y automake autoconf readline-devel ncurses-devel openssl-devel
  dnf install -y libyaml-devel libxslt-devel libffi-devel libtool unixODBC-devel

  dnf install -y fish terminator mc ranger
  dnf install -y lshw nmap net-tools wmctrl
  dnf install -y wicd wicd-gtk volumeicon arandr
  dnf install -y feh i3lock scrot ImageMagick lightdm-webkit2-greeter compton
  dnf install -y tint2 rofi
  dnf install -y htop glances
  dnf install -y neofetch cmatrix
  dnf install -y figlet ddate shutter xclip surf
  dnf install -y docker

  dnf install -y xmonad ghc-xmonad-contrib ghc-xmonad-devel ghc-xmonad-contrib-devel

  dnf install -y gem ruby python python3 python3-wheel python3-devel python-devel
  gem install lolcat
}

main 2>&1 |& tee -a "$LOGFILE"

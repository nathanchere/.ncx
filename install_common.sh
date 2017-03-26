#!/bin/bash

. "./_.sh"

requireRoot

main() {
  dnf copr enable -y konimex/neofetch
  dnf copr enable -y youssefmsourani/telegram-desktop
  dnf copr enable -y antergos/lightdm-webkit2-greeter

  # TODO: Optimise this

  dnf install -y automake autoconf readline-devel ncurses-devel openssl-devel
  dnf install -y libyaml-devel libxslt-devel libffi-devel libtool unixODBC-devel
  dnf install -y fish terminator
  dnf install -y gem
  dnf install -y lshw nmap
  dnf install -y feh i3lock scrot ImageMagick lightdm-webkit-greeter
  dnf install -y tint2
  dnf install -y htop neofetch
  dnf install -y lynx
  dnf install -y figlet ddate
  dnf install -y docker

  dnf install -y xmonad ghc-xmonad-contrib ghc-xmonad-devel ghc-xmonad-contrib-devel
}

main 2>&1 |& tee -a "$LOGFILE"

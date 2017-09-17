#!/bin/bash

. "./_.sh"

requireRoot

main() {
  rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg

  # Choose stable or development
  #sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
  dnf config-manager --add-repo https://download.sublimetext.com/rpm/dev/x86_64/sublime-text.repo

  dnf install sublime-text
}

main 2>&1 |& tee -a "$LOGFILE"

# # for Arch
# Install the GPG key:
#
# curl -O https://download.sublimetext.com/sublimehq-pub.gpg && sudo pacman-key --add sublimehq-pub.gpg && sudo pacman-key --lsign-key 8A8F901A && rm sublimehq-pub.gpg
# Select the channel to use:
#
# Stable
# echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/stable/x86_64" | sudo tee -a /etc/pacman.conf
# Dev
# echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/dev/x86_64" | sudo tee -a /etc/pacman.conf
# Update pacman and install Sublime Text
#
# sudo pacman -Syu sublime-text

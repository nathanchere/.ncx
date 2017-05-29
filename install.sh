#!/usr/bin/env bash

. "./_.sh"

# TODO:

# [DONE] detect environemnt (which package manager to use etc)
# [DONE] config goes into ~/.config
# install dependencies (python etc)
# install essentials e.g. fish stow git
# configure essentials e.g git omf

# standardise output (e.g. die format, headers etc)

# Important stuff

CONFIG_FILE="$HOME/.config/.ncx"
distro='Unknown'

detectEnvironment () {

  highlightOut "Checking distro"

  distro_id='Unknown'
  distro_name='Unknown'
  distro_family='Unknown'

  if [ -f /etc/os-release ]; then

    while read line; do
      if [[ ${line} =~ ^ID= ]]; then distro_id=${line//*=}; fi
      if [[ ${line} =~ ^ID_LIKE= ]]; then distro_family=${line//*=}; fi
      if [[ ${line} =~ ^PRETTY_NAME= ]]; then distro_name=${line//*=}; fi
    done < /etc/os-release

  fi

  # Unknown or unsupported distros

  if [ "$distro_family" == 'Unknown' ]; then
    die "Unable to detect distro information; see README.md for supported distros"
  fi

  if [ "$distro_family" != 'arch' ] && [ "$distro_family" != 'fedora' ]; then
    die "${distro_name} is not supported; see README.md for supported distros"
  fi

  # Warnings for probably-safe-but-untested distros

  if [ "$distro_family" == 'arch' ] && [ "$distro_id" != 'antergos' ] && [ "$distro_id" != 'arch' ]; then
    warnOut 'Arch and Antergos are the only tested Arch variants. Experiences with other distros may vary. Caveat emptor.'
  fi

  if [ "$distro_family" == 'fedora' ] && [ "$distro_id" != 'fedora' ] && [ "$distro_id" != 'korora' ]; then
     warnOut 'Fedora and Korora are the only tested Fedora variants. Experiences with other distros may vary. Caveat emptor.'
  fi

  highlightOut "Detected: ${distro_name} (${distro_family} family)"

  distro=$distro_family
}

detectAlreadyInstalled() {
  if [ -f "$CONFIG_FILE" ]; then
    die ".ncx has already been installed"
  fi

  touch "$CONFIG_FILE"
}

confirmBeforeContinue() {
  read -p "Are you sure you want to run the installer? [y/n]" choice
  case "$choice" in
    y|Y ) return ;;
    n|N ) die "Exiting..." ;;
    * ) echo "Invalid response" ;;
  esac
  confirmBeforeContinue
}

# Pre-install validations

detectEnvironment
#detectAlreadyInstalled
confirmBeforeContinue

echo "Installing!!"

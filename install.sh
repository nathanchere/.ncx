#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

readonly LOG_FILE="/tmp/$(basename "$0").log"
info()    { echo "[INFO]    $@" | tee -a "$LOG_FILE" >&2 ; }
warning() { echo "[WARNING] $@" | tee -a "$LOG_FILE" >&2 ; }
error()   { echo "[ERROR]   $@" | tee -a "$LOG_FILE" >&2 ; }
die()   { echo "[FATAL]   $@" | tee -a "$LOG_FILE" >&2 ; exit 1 ; }

readonly USERNAME=`logname`
readonly HOME=`getent passwd "$USERNAME" | cut -d: -f6`

# Must run as root
if [ "$(whoami)" != "root" ]; then # Can also check $UID != 0
  die "This script requires root privilege. Try again with sudo."
fi

drawTime() {
  date +"%T"
}

drawTimestamp() {
  date +"%y%m%d"
}

# TODO:
# [DONE] detect environemnt (which package manager to use etc)
# [DONE] config goes into ~/.config
# install dependencies (python etc)
# install essentials e.g. fish stow git
# configure system stuff
# configure essentials e.g git omf
# verify install
# - and cleanup partial install on fail? overkill?

# standardise output (e.g. die format, headers etc)
# Add --force flag support to re-install

# Important stuff

CONFIG_FILE="$HOME/.config/.ncx"
distro='Unknown'

detectEnvironment () {

  info "Checking distro"

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
    warning 'Arch and Antergos are the only tested Arch variants. Experiences with other distros may vary. Caveat emptor.'
  fi

  if [ "$distro_family" == 'fedora' ] && [ "$distro_id" != 'fedora' ] && [ "$distro_id" != 'korora' ]; then
     warning 'Fedora and Korora are the only tested Fedora variants. Experiences with other distros may vary. Caveat emptor.'
  fi

  info "Distro: OK; detected: ${distro_name} (${distro_family} family)"

  distro=$distro_family
}

detectCorrectPath() {
  echo "Home is $HOME; running from $(pwd)"
  if [ "$HOME/.ncx" != "$(pwd)" ]; then
    die ".ncx installer must be run from '\$HOME/.ncx'. Because reasons."
  fi
  echo "Install path: OK"
}

detectAlreadyInstalled() {
  if [ -f "$CONFIG_FILE" ]; then
    die ".ncx has already been installed. Use 'ncx help' to see usage."
  fi
  echo "No prior install: OK"
}

confirmBeforeContinue() {
  read -p "Are you sure you want to run the installer? [y/n]" choice
  case "$choice" in
    y|Y ) return ;;
    n|N ) die "Exiting..." ;;
    * ) echo "Invalid response (choose 'y' or 'n')" ;;
  esac
  confirmBeforeContinue
}

initConfigFile() {
  rm -f "$CONFIG_FILE"
  touch "$CONFIG_FILE"
}

addExtraPath(){
  case :$PATH: in
    *:$1:*)
      echo "'$1' already exists in \$PATH"
      ;;
    *)
      echo "Adding '$1' to \$PATH"
      PATH=$1:$PATH
      ;;
  esac
}

addExtraPaths() {
  info "Configuring \$PATH"
  addExtraPath /home/usr/bin
  addExtraPath /usr/bin
  addExtraPath foo/e
}

isPackageInstalled() {
  if [ $distro != "fedora" ]; then
    rpm -q "$1" &> /dev/null
  fi

  if [ $distro != "arch" ]; then
    pacman -Qi "$1" &> /dev/null
  fi

  # note: shitty way of doing this. If any other errors occur,
  #  it will give the impression the package isn't installed when
  #  you really have no idea
  echo $?
}

# Meh, does the job
# $1: dnf package name
# $2: pacman package name
# $3: package description
installPackage() {
  if [ $distro != "fedora" ]; then
    if [ $(isPackageInstalled "$1") ]; then
        echo "Package $1 is already installed; skipping..."
       return
    fi
    echo "Installing $1..."
    sudo dnf install -y $1
    return
  fi

  if [ $distro != "arch" ]; then
    if [ $(isPackageInstalled "$2") ]; then
        echo "Package $2 is already installed; skipping..."
        return
    fi
    echo "Installing $2..."
    sudo pacman --no-confirm -S $2
    return
  fi
}

installPrereqs() {
  # These should be the only packages to need installing outside ncx
  installPackage stow stow "GNU stow"
  installPackage python3 python "Python 3.x"
}

installUserConfig() {
  # add groups and rules for things like user backlight permissions
  rsync -avm "system/udev/" "/etc/udev/rules.d"
  gpasswd -a "$USERNAME" video
}

debugCleanInstall() {
  # TODO: repurpose as a --force flag
  echo "DEBUG: cleaning existing install"
  rm -f "$CONFIG_FILE"
}

installNcxUtil () {
  echo
  # TODO: stow to /usr/bin
}

# # # # # # # # # # # # # # # # # #
# Main
# # # # # # # # # # # # # # # # # #

debugCleanInstall # To manually force to treat as a 'clean install'

# Pre-install validations

detectEnvironment
detectAlreadyInstalled
detectCorrectPath
confirmBeforeContinue

echo "Installing, hold on to your hats..."

initConfigFile
addExtraPaths
installPrereqs
installNcxUtil
installUserConfig

cleanup() {
  echo Cleaning up
}
trap cleanup EXIT

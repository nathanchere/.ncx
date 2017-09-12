#!/usr/bin/env bash
## Helpers for dealing with package management systems

[[ ${ONCE_PACKAGE:-} -eq 1 ]] && return || readonly ONCE_PACKAGE=1
[ $(basename "$0") = $(basename "$BASH_SOURCE") ] && echo "This should not be run directly" && exit 111
echo "[ including _package.sh ]"

. "system/_.sh"
. "system/_distro.sh"

# $1: package name as you would provide it to dnf/pacman/etc
# Returns installed package version number, or empty if not installed
installedVersion() {
  if ! isPackageInstalled $1; then
    echo ''
    return
  fi

  case "$DISTRO_FAMILY" in
    'fedora') rpm -qi "$1" | grep "Version" | cut -d ':' -f 2 | cut -d ' ' -f 2  ;;
    'arch') pacman -Qi "$1" | grep "Version" | cut -d ':' -f 2 | cut -d ' ' -f 2 ;;
    'ubuntu') dkpg -s "$1" | grep "Version" | cut -d ':' -f 2 | cut -d ' ' -f 2 ;;
    'nixos') die "TODO: I don't know how to do this :)" ;;
    *) die "Unable to check packages for $DISTRO family of distros" ;;
  esac
}

# $1: package name as you would provide it to dnf/pacman/etc
# Returns true if specified package is installed, false otherwise
# Will give potentially give false negative if any errors occur :(
isPackageInstalled() {
  case "$DISTRO_FAMILY" in
    'fedora') isPackageInstalledFedora $1 ;;
    'arch') isPackageInstalledArch $1 ;;
    'ubuntu') isPackageInstalledDebian $1 ;;
    'nixos') isPackageInstalledNixos $1 ;;
    *) die "Unable to check packages for $DISTRO family of distros" ;;
  esac
}

isPackageInstalledFedora() {
  log "Checking for Fedora package $1"
  rpm -q "$1" &> /dev/nullb
}

# TODO: how to check for non-pacman in arch, eg AUR
isPackageInstalledArch() {
  log "Checking for Arch package $1"
  pacman -Q "$1" &> /dev/null
}

isPackageInstalledDebian() {
  die "Not supported"
}

isPackageInstalledNixos() {
  log "Checking for NixOS package $1"
  nix-dev -q "$1" &> /dev/null
}

# Meh, does the job
# $1: package description
# $2: dnf package name
# $3: pacman package name
# if a package isn't needed for a particular system, leave as ''
installPackage() {
  package=''
  case "$DISTRO_FAMILY" in
    'fedora') package=$2 ;;
    'arch') package=$3 ;;
    *) die "Package installation not supported for $DISTRO; can't install $1" ;;
  esac

  if [[ "$package" == '' ]]; then
    log "$1 not needed for $DISTRO; skipping..."
    return
  fi

  if isPackageInstalled "$package"; then
      log "Package '$package' ($1) is already installed; skipping..."
      return
  fi

  log "Installing $package..."
  case "$DISTRO_FAMILY" in
    'fedora') sudo dnf install -y $package ;;
    'arch') sudo pacman --noconfirm -S $package ;;
    *) die "Package installation not supported for $DISTRO; can't install $1" ;;
  esac
}

#######################################
#
#  Exports
#
#######################################

export -f installPackage
export -f installedVersion
export -f isPackageInstalled

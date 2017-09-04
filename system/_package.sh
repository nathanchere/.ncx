#!/usr/bin/env bash
## Helpers for dealing with package management systems

[[ ${ONCE_PACKAGE:-} -eq 1 ]] && return || readonly ONCE_PACKAGE=1
[ $(basename "$0") = $(basename "$BASH_SOURCE") ] && echo "This should not be run directly" && exit 111

. "system/_.sh"
. "system/_distro.sh"

# Pass in the name of a package as you would provide it to dnf/yum/etc
installedVersion() {
 $distro=`getDistro`
 "$distro" == "fedora" && rpm -qi "$1" | grep "Version" | cut -d ':' -f 2 | cut -d ' ' -f 2
 "$distro" == "arch" && rpm -qi "$1" | grep "Version" | cut -d ':' -f 2 | cut -d ' ' -f 2
}

# $1: dnf package name
isPackageInstalled() {
 echo "Checking for Fedora package '$1'"
 rpm -q "$1" &> /dev/null

 # note: shitty way of doing this. Will give potentially give false negative if any errors occur
 return $?
}

# $1: dnf package name
isPackageInstalledFedora() {
 echo "Checking for Fedora package '$1'"
 rpm -q "$1" &> /dev/nullb

 # note: shitty way of doing this. Will give potentially give false negative if any errors occur
 return $?
}

# $1: pacman package name
# TODO: how to check for non-pacman in arch, eg AUR
isPackageInstalledArch() {
 echo "Checking for Arch package '$1'"
 pacman -Q "$1" &> /dev/null

 # note: shitty way of doing this. Will give potentially give false negative if any errors occur
 return $?
}

#######################################
#
#  Variable exports
#
#######################################

export -f installedVersion
export -f isPackageInstalled

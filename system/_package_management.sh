#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

[[ ${INCLUDEONCE:-} -eq 1 ]] && return || readonly INCLUDEONCE=1
[ $(basename "$0") = $(basename "$BASH_SOURCE") ] && echo "This should not be run directly" && exit 111


#######################################
#
#  Environment and package management stuff
#
#######################################

 # Pass in the name of a package as you would provide it to dnf/yum/etc
 installedVersion() {
   "$distro" == "fedora" && rpm -qi "$1" | grep "Version" | cut -d ':' -f 2 | cut -d ' ' -f 2
   "$distro" == "arch" && rpm -qi "$1" | grep "Version" | cut -d ':' -f 2 | cut -d ' ' -f 2
 }


export -f yell
export -f die
export -f try
export -f requireRoot
export -f requireNotRoot
export -f addToFileOnce
export -f drawTime
export -f drawTimestamp
export -f promptYesNo
export -f download

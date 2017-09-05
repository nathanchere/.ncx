#!/usr/bin/env bash

set -uo pipefail
IFS=$'\n\t'

[[ ${INCLUDEONCE:-} -eq 1 ]] && return || readonly INCLUDEONCE=1
[ $(basename "$0") = $(basename "$BASH_SOURCE") ] && echo "This should not be run directly" && exit 111
echo "[ including _.sh ]"

#######################################
#
#  Environment and package management stuff
#
#######################################

getUserName(){
  if [[ $EUID -ne 0 ]]; then
    echo `whoami`
  else
    echo "$SUDO_USER"
  fi
}

# Tips from http://stackoverflow.com/a/25515370/243557
# Print the script name and all arguments to std:err
yell() { echo "$*" 2>&1 |& tee -a "$LOGFILE"; }
# Same as yell but exits with error status
die() { yell "$*"; exit 111; }
# Uses boolean shortcircuit to only die if the specified command failed
try() { "$@" || die "cannot $*"; }

log() {
  printf "\033[1;37m[[ \033[1;36m* \033[1;37m]] \033[0m$1\n"
  echo $@ >> "$LOGFILE"
}

requireRoot() {
  [[ "$(whoami)" == "root" ]] || die "This script requires root privileges. Try again with sudo."
}

requireNotRoot() {
  "$(whoami)" != "root" || die "This script should not be run as root."
}

# Stolen from Redhat /etc/profile
# Append to PATH if not already specified
# $1 - string to add to PATH if not already present
# $2 - if 'after', $1 will be added to the end of PATH instead of the start
pathMunge() {
  if ! echo $PATH | /bin/egrep -q "(^|:)$1($|:)" ; then
    if [ "$2" = "after" ] ; then
      PATH=$PATH:$1
    else
      PATH=$1:$PATH
    fi
  fi
}

# $1 - the string to be added (if not already present)
# $2 - the file to add to
addToFileOnce() {
  grep -qF "$1" "$2" || echo "$1" >> "$2"
}

drawTime() {
  date +"%T"
}

drawTimestamp() {
  date +"%y%m%d"
}

# Prompt for Y/N input and return either true (Y) or false (N)
# $1 - prompt text
promptYesNo() {
  while true; do
    read -p "$1 [y/n]: " yn
    case $yn in
        [Yy]* ) return 0 ;;
        [Nn]* ) return 1 ;;
    esac
  done
}

# $1- url
# $2- local path to download to
download () {
  # -L to follow Github redirects like e.g. Github uses
  curl -L "$1" --create-dirs -o "$2"
}

 #######################################
 #
 #  Exports
 #
 #######################################

export USERNAME=`getUserName`
export HOME=`getent passwd "$USERNAME" | cut -d: -f6`
export NCXROOT="$HOME/.ncx"
export LOGROOT="$NCXROOT/logs"
export TMPROOT="$NCXROOT/tmp"

export CONFIG_FILE="$HOME/.config/.ncx"
export LOGFILE="$LOGROOT/$(basename "$0").log"

mkdir -p "$LOGROOT"

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

#!/bin/bash

[[ ${INCLUDEONCE:-} -eq 1 ]] && return || readonly INCLUDEONCE=1

# Common config stuff

# Exit on the first failure - it's bulletproof or GTFO
set -e

# Error on referencing any undefined variables (sanity check)
set -u

# Tips from http://stackoverflow.com/a/25515370/243557
yell() { echo "$*" 2>&1 |& tee -a "$LOGFILE"; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }

# Nice formatty stuff

requireRoot() {
  if [ "$(whoami)" != "root" ]; then # Can also check $UID != 0
    die "This script requires root privilege. Try again with sudo."
  fi
}

drawTime() {
  echo `date +"%T"`
}

drawTimestamp() {
  echo `date +"%y%m%d"`
}

drawHead() {
  echo " "
  echo "########################################################"
  echo "#  $1"
  echo "########################################################"
  echo " "
}

drawSubhead() {
  echo " "
  echo "[$(drawTime)]------------------------------------------------"
  echo "          ::: $1"
  echo " "
}

# Stow common wrapper
#   $1 - root name of stow source
#   $2 - parent folder of stow source
#   $3 - root of stow target
# e.g. doStow compton dotfiles /home/johnnychomp

doStow() {
  drawSubhead "Cleaning up existing $1 files"
  stow --verbose=2 -D -d "$2" -t "$3" "$1"
  drawSubhead "Stowing $1"
  stow --verbose=2 -d "$2" -t "$3" "$1"
}

# Since stow only works with symlinks, and because permission issues arise for
# things like display manager config which is not run from an account which
# has permission to access files in the main .ncx repository (when it is cloned
# under /home/{user} as intended), this is a kind of work-around using hard links.
# NOTE: does not recurse through subdirectories.
# Basically intended as a simplistic shallow stow with hard links.
#   $1 - path to the 'stow' source folder, relative from .ncx root
#   $2 - root of stow target

doHardStow() {
  drawSubhead "Hard-stowing $1 config"

  for SOURCEPATH in "$NCXROOT/$1"/*.*; do
    FILENAME=$(basename "$SOURCEPATH")
    TARGETPATH="$2/$FILENAME"

    if [ -d "$TARGETPATH" ]; then
      echo "Skipping directory $TARGETPATH"
    else
      if [ -L "$TARGETPATH" ]; then
        echo "$FILENAME already symlinked; unlinking..."
        unlink "$TARGETPATH"
      elif [ -f "$TARGETPATH" ]; then
          echo "$FILENAME already exists as $TARGETPATH; backing up..."
          BAKNAME="$TARGETPATH.$(drawTimestamp).bak"
          rm -f "$BAKNAME"
          mv "$TARGETPATH" "$BAKNAME"
      fi

      echo "Hard-linking $SOURCEPATH to $TARGETPATH"
      ln "$SOURCEPATH" "$TARGETPATH"
      echo "Setting a+rx on $TARGETPATH"
      chmod a+rx "$TARGETPATH"
    fi
  done
}

# $1- url
# $2- local path to download to
download () {
  # -L to follow Github redirects like e.g. Github uses
  curl -L "$1" --create-dirs -o "$2"
}

# Pass in the name of a package as you would provide it to dnf/yum/etc
installedVersion() {
  echo $(rpm -qi "$1" | grep "Version" | cut -d ':' -f 2 | cut -d ' ' -f 2)
}

# ensure a value is only added to a file once
# $1 - FILENAME
# $2 - content
appendOnce () {
  touch "$1"
  if [ ! cat "$1" | grep -q "$2" ]; then
    echo "Appeding to $1"
    echo -e "$2" >> "$1"
  else
    echo "$1 already contains target string, skipping..."
  fi
}

# Init common variables
export HOME="$(dirname $(pwd))" # make sure sudo doesn't mess up $HOME
export NCXROOT=$(pwd)
LOGROOT="$NCXROOT/logs"
TMPROOT="$NCXROOT/tmp"
export LOGFILE="$LOGROOT/$0.log"

if [ $0 != "ncx" ]; then
  # Init log
  mkdir -p logs
  # Common header format
  drawHead "$0 [$(date)]" |& tee -a "$LOGFILE"
fi

# Function exports
export -f drawHead
export -f yell
export -f die
export -f try
export -f requireRoot

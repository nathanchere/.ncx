#!/bin/bash
# Common config stuff

#TODO:  2>&1 | tee logs/install.log

# Exit on the first failure - it's bulletproof or GTFO
set -e

# Error on referencing any undefined variables (sanity check)
set -u

# Tips from http://stackoverflow.com/a/25515370/243557
yell() { echo "$*" 2>&1 |& tee -a $LOGFILE; }
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
  stow --verbose=2 -D -d $2 -t $3 $1  
  drawSubhead "Stowing $1"
  stow --verbose=2 -d $2 -t $3 $1
}

# Pass in the name of a package as you would provide it to dnf/yum/etc

installedVersion() {
  echo $(rpm -qi $1 | grep "Version" | cut -d ':' -f 2 | cut -d ' ' -f 2)
}

# Init common variables
export NCXROOT=$(pwd)
LOGROOT="$NCXROOT/logs"
TMPROOT="$NCXROOT/tmp"
export LOGFILE="$LOGROOT/$0.log"

# Init log
mkdir -p logs
drawHead "$0 [$(date)]" |& tee -a $LOGFILE

# Function exports
export -f drawHead
export -f yell
export -f die
export -f try
export -f requireRoot

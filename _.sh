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
  if [ $UID != 0 ]; then
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

# Init common variables
export NCXROOT=$(pwd)
LOGROOT="$NCXROOT/logs"
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

#!/bin/bash
. _.sh

requireRoot

stowSysConfig() {
  drawSubhead "Cleaning up existing $1 files"
  stow --verbose=2 -D -d sysconfig -t / $1  
  drawSubhead "Stowing $1"
  stow --verbose=2 -d sysconfig -t / $1  
}

main() {
  stowSysConfig xsessions
}

main 2>&1 |& tee -a $LOGFILE

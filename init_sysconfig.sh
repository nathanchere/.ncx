#!/bin/bash
. _.sh

# System config is handled at root ("/") level rather than home
# For this reason it's handled separately from normal dotfiles
requireRoot

main() {
  stowSysConfig xsessions sysconfig /
}

main 2>&1 |& tee -a $LOGFILE

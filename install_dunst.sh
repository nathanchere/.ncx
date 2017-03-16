#!/bin/bash
. _.sh

requireRoot

main() {
  dnf install -y dunst
}

main 2>&1 |& tee -a $LOGFILE

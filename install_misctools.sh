#!/bin/bash
. _.sh

requireRoot

main() {
  dnf install -y lshw feh
}

main 2>&1 |& tee -a "$LOGFILE"

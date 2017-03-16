#!/bin/bash
. _.sh

requireRoot

main() {
  dnf install -y lshw
}

main 2>&1 |& tee -a $LOGFILE

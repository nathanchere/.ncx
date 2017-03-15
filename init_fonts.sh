#!/bin/bash
. _.sh

main() {
  doStow fonts resources ~
  fc-cache -fv
}

main 2>&1 |& tee -a $LOGFILE


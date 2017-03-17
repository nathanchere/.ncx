#!/bin/bash
. _.sh

requireRoot

main() {
  doHardStow sysconfig/xsessions /usr/share/xsessions
  doHardStow sysconfig/lightdm /etc/lightdm
}

main 2>&1 |& tee -a "$LOGFILE"

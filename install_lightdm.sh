#!/bin/bash
. _.sh

requireRoot

main() {
  dnf copr enable -y antergos/lightdm-webkit2-greeter
  dnf install -y lightdm-webkit-greeter
}

main 2>&1 |& tee -a "$LOGFILE"

#!/bin/bash
. _.sh

requireRoot

main() {
  drawSubhead "Fixing lightdm config permissions"
  chmod a+r -R ./sysconfig/lightdm/

  drawSubhead "Copying lightdm config files"
  rsync -avm sysconfig/lightdm/. "/etc/lightdm"
}

main 2>&1 |& tee -a "$LOGFILE"

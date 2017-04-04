#!/bin/bash

. "./_.sh"

requireRoot

main() {
  drawSubhead "Fixing repo permissions"
  chmod +rw -R ./sysconfig/rpmrepos/

  drawSubhead "Copying yum repo definitions"
  rsync -avmi sysconfig/rpmrepos/. "/etc/yum.repos.d"
}

main 2>&1 |& tee -a "$LOGFILE"

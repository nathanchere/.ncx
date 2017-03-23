#!/bin/bash

. "./_.sh"

requireRoot

main() {
  drawSubhead "Fixing xsession permissions"
  chmod a+r -R ./sysconfig/xsessions/

  drawSubhead "Copying xsession files"
  rsync -avmi sysconfig/xsessions/. "/usr/share/xsessions"
}

main 2>&1 |& tee -a "$LOGFILE"

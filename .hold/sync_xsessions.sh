#!/bin/bash

. "./_.sh"

requireRoot

main() {
  drawSubhead "Fixing xsession permissions"
  chmod a+r -R ./system/xsessions/

  drawSubhead "Copying xsession files"
  rsync -avmi system/xsessions/. "/usr/share/xsessions"
}

main 2>&1 |& tee -a "$LOGFILE"

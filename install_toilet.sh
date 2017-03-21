#!/bin/bash
. _.sh

die "Doesn't work yet"

requireRoot

main() {
  REPO="kmf/Toilet"

  drawSubhead "Installing toilet from COPR"
  dnf copr enable -y "$REPO"
  dnf install -y toilet
}

main 2>&1 |& tee -a "$LOGFILE"

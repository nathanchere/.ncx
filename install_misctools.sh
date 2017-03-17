#!/bin/bash
. _.sh

requireRoot

main() {
  dnf install -y lshw feh i3lock scrot ImageMagick
}

main 2>&1 |& tee -a "$LOGFILE"

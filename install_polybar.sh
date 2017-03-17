#!/bin/bash
. _.sh

requireRoot

ORIGINALPATH=$(pwd)

main() {
  # For more info on what is happening here, see blog post (link TBC - 2017/03/15)

  drawSubhead "Installing build dependencies"
  sudo dnf install cmake @development-tools gcc-c++
  sudo dnf install cairo-devel xcb-proto xcb-util-devel xcb-util-wm-devel xcb-util-image-devel

  drawSubhead "Installing module dependencies"
  sudo dnf install i3-ipc jsoncpp-devel alsa-lib-devel wireless-tools-devel libmpdclient-devel libcurl-devel

  drawSubhead "Getting latest polybar source"
  BUILDPATH="$TMPROOT/polybar"
  rm -rf "$BUILDPATH"
  git clone --recursive https://github.com/jaagr/polybar "$BUILDPATH"
  cd "$BUILDPATH"

  # Check out the latest tagged release
  currentRelease=$(git describe --tags `git rev-list --tags --max-count=1`)
  git checkout "$currentRelease"

  drawSubhead "Build polybar"
  ./build.sh

  cd "$ORIGINALPATH"
}

main 2>&1 |& tee -a "$LOGFILE"

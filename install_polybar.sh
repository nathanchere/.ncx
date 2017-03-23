#!/bin/bash

. "./_.sh"

requireRoot

ORIGINALPATH=$(pwd)

main() {
  # For more info on what is happening here, see blog post (link TBC - 2017/03/15)

  drawSubhead "Installing build dependencies"
  sudo dnf install cmake @development-tools gcc-c++
  sudo dnf install cairo-devel xcb-proto xcb-util-devel xcb-util-wm-devel xcb-util-image-devel

  drawSubhead "Installing module dependencies"
  sudo dnf install i3-ipc jsoncpp-devel alsa-lib-devel wireless-tools-devel libmpdclient-devel libcurl-devel

  BUILDPATH="$TMPROOT/polybar"
  drawSubhead "Getting latest polybar source into $BUILDPATH"
  rm -rf "$BUILDPATH"
  git clone --recursive https://github.com/jaagr/polybar "$BUILDPATH"
  cd "$BUILDPATH"

  # Check out the latest tagged release
  currentRelease=$(git describe --tags `git rev-list --tags --max-count=1`)
  git checkout "$currentRelease"
  git submodule update --init --recursive

  drawSubhead "Build polybar"
  mkdir "$BUILDPATH/build"
  cd "$BUILDPATH/build"

  cmake \
    -DCMAKE_C_COMPILER="gcc" -DCMAKE_CXX_COMPILER="g++" \
    -DENABLE_ALSA:BOOL="ON" -DENABLE_MPD:BOOL="ON" \
    -DENABLE_NETWORK:BOOL="ON" -DENABLE_CURL:BOOL="ON" \
    -DENABLE_I3:BOOL="OFF" \
    -DBUILD_IPC_MSG:BOOL="ON" .. || die "cmake failed"

  make || die "make failed"
  make install

  cd "$ORIGINALPATH"
}

main 2>&1 |& tee -a "$LOGFILE"

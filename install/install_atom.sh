#!/bin/bash

. "./_.sh"

requireRoot

latestAtomRpmUrl() {
  echo $(curl -sL "https://api.github.com/repos/atom/atom/releases/latest" | grep "https.*atom.x86_64.rpm" | cut -d '"' -f 4)
}

installedAtomVersion() {
  echo $(rpm -qi atom | grep "Version" | cut -d ':' -f 2 | cut -d ' ' -f 2)
}

latestAtomVersion() {
  echo $(curl -sL "https://api.github.com/repos/atom/atom/releases/latest" | grep -E "https.*atom.x86_64.rpm" | cut -d '"' -f 4 | cut -d '/' -f 8 | sed 's/v//g' )
}

main() {
  drawSubhead "Checking installed vs latest Atom versions"
  INSTALLEDVERSION=$(installedAtomVersion)
  LATESTVERSION=$(latestAtomVersion)

  if [ "$INSTALLEDVERSION" == "$LATESTVERSION" ]; then
    echo "Latest version $LATESTVERSION already installed; skipping..."
  else
    if [ "$INSTALLEDVERSION" == "" ]; then
      echo "No previous Atom installation detected; installing $LATESTVERSION"
    else
      echo "Outdated version $INSTALLEDVERSION installed; updating to $LATESTVERSION"
    fi

    DOWNLOADURL=$(latestAtomRpmUrl)
    INSTALLER="$TMPROOT/atom-$LATESTVERSION.rpm"
    rm -f "$INSTALLER"
    echo "Downloading from $DOWNLOADURL to $INSTALLER"
    download "$DOWNLOADURL" "$INSTALLER"
    dnf install -y "$TMPROOT/atom-$LATESTVERSION.rpm"
  fi
}

main 2>&1 |& tee -a "$LOGFILE"

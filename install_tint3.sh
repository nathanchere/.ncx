#!/bin/bash
. _.sh

requireRoot

latestTintRpmUrl() {
  echo $(curl -sL "https://api.github.com/repos/jmc-88/tint3/releases/latest" | grep "https.*tint3.*amd64.rpm" | cut -d '"' -f 4)
}

installedTintVersion() {
  echo $(rpm -qi atom | grep "Version" | cut -d ':' -f 2 | cut -d ' ' -f 2)
}

latestTintVersion() {
  echo $(curl -sL "https://api.github.com/repos/jmc-88/tint3/releases/latest" | grep -E "https.*tint3.*amd64.rpm" | cut -d '"' -f 4 | cut -d '/' -f 8 | sed 's/v//g' )
}

main() {

  die "Doesn't provide x86_64 builds yet, only amd64"

  drawSubhead "Checking installed vs latest Tint3 versions"
  INSTALLEDVERSION=$(installedTintVersion)
  LATESTVERSION=$(latestTintVersion)

  if [ "$INSTALLEDVERSION" == "$LATESTVERSION" ]; then
    echo "Latest version $LATESTVERSION already installed; skipping..."
  else
    if [ "$INSTALLEDVERSION" == "" ]; then
      echo "No previous Tint installation detected; installing $LATESTVERSION"
    else
      echo "Outdated version $INSTALLEDVERSION installed; updating to $LATESTVERSION"
    fi

    DOWNLOADURL=$(latestTintRpmUrl)
    INSTALLER="$TMPROOT/tint-$LATESTVERSION.rpm"
    rm -f "$INSTALLER"
    echo "Downloading from $DOWNLOADURL to $INSTALLER"
    curl -L "$DOWNLOADURL" -o "$INSTALLER" # -L to follow Github redirects
    dnf install -y "$INSTALLER"
  fi
}

main 2>&1 |& tee -a "$LOGFILE"

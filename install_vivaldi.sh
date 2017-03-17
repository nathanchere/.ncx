#!/bin/bash
. _.sh

requireRoot

latestVivaldiRpmUrl() {
  echo $(curl -sL "https://vivaldi.com/download" | grep "https.*vivaldi-stable-.*.x86_64.rpm" | cut -d '"' -f 4)
}

latestVivaldiVersion() {
  echo $(curl -sL "https://vivaldi.com/download" | grep -E "https.*vivaldi-stable-.*.x86_64.rpm" | cut -d '"' -f 4 | cut -d '/' -f 5 | cut -d '-' -f 3 )
}

main() {
  drawSubhead "Checking installed vs latest Vivaldi versions"
  INSTALLEDVERSION=$(installedVersion "vivaldi-stable")
  LATESTVERSION=$(latestVivaldiVersion)

  if [ "$INSTALLEDVERSION" == "$LATESTVERSION" ]; then
    echo "Latest version $LATESTVERSION already installed; skipping..."
  else
    if [ "$INSTALLEDVERSION" == "" ]; then
      echo "No previous Vivaldi installation detected; installing $LATESTVERSION"
    else
      echo "Outdated version $INSTALLEDVERSION installed; updating to $LATESTVERSION"
    fi
    exit
    DOWNLOADURL=$(latestVivaldiRpmUrl)
    INSTALLER="$TMPROOT/vivaldi-$LATESTVERSION.rpm"
    rm -f "$INSTALLER"
    echo "Downloading from $DOWNLOADURL to $INSTALLER"
    curl -L "$(latestVivaldiRpmUrl)" -o "$INSTALLER" # -L to follow Github redirects
    dnf install -y "$TMPROOT/vivaldi-$LATESTVERSION.rpm"
  fi
}

main 2>&1 |& tee -a "$LOGFILE"

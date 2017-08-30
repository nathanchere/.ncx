#!/bin/bash

. "./_.sh"

latestExercismUrl() {
  echo "https://github.com/exercism/cli/releases/download/v2.4.0/exercism-linux-64bit.tgz"
  #echo $(curl -sL "https://api.github.com/repos/atom/atom/releases/latest" | grep "https.*atom.x86_64.rpm" | cut -d '"' -f 4)
}

installedExercismVersion() {
  echo ""
  #echo $(rpm -qi atom | grep "Version" | cut -d ':' -f 2 | cut -d ' ' -f 2)
}

latestExercismVersion() {
  echo "2.4.0"
  #echo $(curl -sL "https://api.github.com/repos/atom/atom/releases/latest" | grep -E "https.*atom.x86_64.rpm" | cut -d '"' -f 4 | cut -d '/' -f 8 | sed 's/v//g' )
}

main() {
  #drawSubhead "Checking installed vs latest Atom versions"
  #INSTALLEDVERSION=$(installedAtomVersion)
  LATESTVERSION=$(latestExercismVersion)
  #
  # if [ "$INSTALLEDVERSION" == "$LATESTVERSION" ]; then
  #   echo "Latest version $LATESTVERSION already installed; skipping..."
  # else
    # if [ "$INSTALLEDVERSION" == "" ]; then
    #   echo "No previous Atom installation detected; installing $LATESTVERSION"
    # else
    #   echo "Outdated version $INSTALLEDVERSION installed; updating to $LATESTVERSION"
    # fi

    DOWNLOADURL=$(latestExercismUrl)
    INSTALLER="$TMPROOT/exercism-$LATESTVERSION.tgz"
    rm -f "$INSTALLER"
    echo "Downloading from $DOWNLOADURL to $INSTALLER"
    download "$DOWNLOADURL" "$INSTALLER"
    tar -xzvf "$TMPROOT/exercism-$LATESTVERSION.tgz" -C "$HOME/bin"
  #fi
}

main 2>&1 |& tee -a "$LOGFILE"

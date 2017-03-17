#!/bin/bash
. _.sh

requireRoot

installXsessions() {

  # This is done with hard links instead of stow's symlinks due to permission
  # issues. If the account running LightDM (or whatever DM) doesn't have
  # permission to access wherever the repo is cloned to (i.e. specific user's
  # home directory) it will not display the corresponding session options.

  drawSubhead "Installing XSession .desktop files"

  for SOURCEPATH in $NCXROOT/sysconfig/xsessions/*.*; do
    FILENAME=$(basename $SOURCEPATH)
    TARGETPATH="/usr/share/xsessions/$FILENAME"

    if [ -f $TARGETPATH ]; then
      echo "$FILENAME already exists as $TARGETPATH; skipping..."
    else

      if [ -L $TARGETPATH ]; then
        echo "$FILENAME already symlinked; unlinking..."
        unlink $TARGETPATH
      fi

      echo "Hard-linking $SOURCEPATH to $TARGETPATH"
      ln $SOURCEPATH $TARGETPATH
    fi
  done
}


main() {
  installXsessions
}

main 2>&1 |& tee -a $LOGFILE

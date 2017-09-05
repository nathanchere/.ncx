#!/usr/bin/env bash
## Helpers for dealing with package management systems

[[ ${ONCE_SYNC:-} -eq 1 ]] && return || readonly ONCE_SYNC=1
[ $(basename "$0") = $(basename "$BASH_SOURCE") ] && echo "This should not be run directly" && exit 111
echo "[ including _sync.sh ]"

. "system/_.sh"

# Stow common wrapper
#   $1 - root name of stow source
#   $2 - parent folder of stow source
#   $3 - root of stow target
# e.g. doStow compton dotfiles /home/johnnychomp

doStow() {
  log "Cleaning up existing $1 files"
  stow --verbose=2 -D -d "$2" -t "$3" "$1"
  log "Stowing $1"
  stow --verbose=2 -d "$2" -t "$3" "$1"
}

# Since stow only works with symlinks, and because permission issues arise for
# things like display manager config which is not run from an account which
# has permission to access files in the main .ncx repository (when it is cloned
# under /home/{user} as intended), this is a kind of work-around using hard links.
# NOTE: does not recurse through subdirectories.
# Basically intended as a simplistic shallow stow with hard links.
#   $1 - path to the 'stow' source folder, relative from .ncx root
#   $2 - root of stow target

doHardStow() {
  drawSubhead "Hard-stowing $1 config"

  for SOURCEPATH in "$NCXROOT/$1"/*.*; do
    FILENAME=$(basename "$SOURCEPATH")
    TARGETPATH="$2/$FILENAME"

    if [ -d "$TARGETPATH" ]; then
      echo "Skipping directory $TARGETPATH"
    elses
      if [ -L "$TARGETPATH" ]; then
        echo "$FILENAME already symlinked; unlinking..."
        unlink "$TARGETPATH"
      elif [ -f "$TARGETPATH" ]; then
          echo "$FILENAME already exists as $TARGETPATH; backing up..."
          BAKNAME="$TARGETPATH.$(drawTimestamp).bak"
          rm -f "$BAKNAME"
          mv "$TARGETPATH" "$BAKNAME"
      fi

      echo "Hard-linking $SOURCEPATH to $TARGETPATH"
      ln "$SOURCEPATH" "$TARGETPATH"
      echo "Setting a+rx on $TARGETPATH"
      chmod a+rx "$TARGETPATH"
    fi
  done
}

# head() { echo -e "========================\n$@\n========================\n\n" | tee -a "$LOG_FILE" >&2 ; }
# log()    { echo -e "$@" | tee -a "$LOG_FILE" >&2 ; }
# info()    { echo -e "[INFO]    $@" | tee -a "$LOG_FILE" >&2 ; }
# warning() { echo -e "[WARNING] $@" | tee -a "$LOG_FILE" >&2 ; }
# error()   { echo -e "[ERROR]   $@" | tee -a "$LOG_FILE" >&2 ; }
# die()   { echo -e "[FATAL]   $@" | tee -a "$LOG_FILE" >&2 ; exit 1 ; }

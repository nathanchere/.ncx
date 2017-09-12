#!/usr/bin/env bash

# Stolen from Redhat /etc/profile
# Append to PATH if not already specified
# $1 - string to add to PATH if not already present
# $2 - if 'after', $1 will be added to the end of PATH instead of the start
pathMungeBefore() {
  if ! echo $PATH | /bin/egrep -q "(^|:)$1($|:)" ; then
      PATH=$1:$PATH
  fi
}

pathMungeAfter() {
  if ! echo $PATH | /bin/egrep -q "(^|:)$1($|:)" ; then
      PATH=$PATH:$1
  fi
}

# PLACEHOLDER: append pathMunge calls here

#!/usr/bin/env bash
#
# Helpers for dealing with distro detection

[[ ${ONCE_DISTRO:-} -eq 1 ]] && return || readonly ONCE_DISTRO=1
[ $(basename "$0") = $(basename "$BASH_SOURCE") ] && echo "This should not be run directly" && exit 111

. "system/_.sh"

getDistro() {
  echo "DistrA=$DISTRO"
  [ -z $DISTRO ] && detectDistro
  echo "DistrB=$DISTRO"
  echo $DISTRO
}

detectDistro () {

  echo "Checking distro"

  distro_id='Unknown'
  distro_name='Unknown'
  distro_family='Unknown'

  if [ -f /etc/os-release ]; then

   while read line; do
     if [[ ${line} =~ ^ID= ]]; then distro_id=${line//*=}; fi
     if [[ ${line} =~ ^ID_LIKE= ]]; then distro_family=${line//*=}; fi
     if [[ ${line} =~ ^PRETTY_NAME= ]]; then distro_name=${line//*=}; fi
   done < /etc/os-release

  fi

  # Exit here on unknown or unsupported distros
  if [ "$distro_family" == 'Unknown' ]; then
   die "Unable to detect distro information; see README.md for supported distros"
  fi

  if [ "$distro_family" != 'arch' ] && [ "$distro_family" != 'fedora' ]; then
   die "${distro_name} is not supported; see README.md for supported distros"
  fi

  # Warnings for probably-safe-but-untested distros

  if [ "$distro_family" == 'arch' ] && [ "$distro_id" != 'antergos' ] && [ "$distro_id" != 'arch' ]; then
   warning 'Arch and Antergos are the only tested Arch variants. Experiences with other distros may vary. Caveat emptor.'
  fi

  if [ "$distro_family" == 'fedora' ] && [ "$distro_id" != 'fedora' ] && [ "$distro_id" != 'korora' ]; then
    warning 'Fedora and Korora are the only tested Fedora variants. Experiences with other distros may vary. Caveat emptor.'
  fi

  echo "Distro: OK; detected: ${distro_name} (${distro_family} family)"

  readonly DISTRO=$distro_family
}

#######################################
#
#  Exports
#
#######################################

export DISTRO=''
export -f getDistro

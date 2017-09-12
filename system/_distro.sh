#!/usr/bin/env bash
#
# Detects distro type from major families or exits if unrecognised / not supported
# Currently supported:
#  id        family
#  -------   -------
#  arch      arch
#  manjaro   arch
#  antergos  arch
#  fedora    fedora
#  korora    fedora

[[ ${ONCE_DISTRO:-} -eq 1 ]] && return || readonly ONCE_DISTRO=1
[ $(basename "$0") = $(basename "$BASH_SOURCE") ] && echo "This should not be run directly" && exit 111
echo "[ including _distro.sh ]"

. "system/_.sh"

log "Detecting distro"

distro_id='unknown'
distro_name='unknown'
distro_family='unknown'
distro_package_manager='unknown'

if [ ! -f /etc/os-release ]; then
  die "No /etc/os-release file found - what crazy mong-arse distro are you on?"
fi

while read line; do
 if [[ ${line} =~ ^ID= ]]; then distro_id=${line//*=}; fi
 if [[ ${line} =~ ^ID_LIKE= ]]; then distro_family=${line//*=}; fi
 if [[ ${line} =~ ^PRETTY_NAME= ]]; then distro_name=${line//*=}; fi
done < /etc/os-release


# Manjaro override
[ "$distro_family" == 'unknown' ] &&  [ "$distro_id" == 'manjaro' ] \
  && distro_family='arch'

# if no ID_LIKE value found, set it to the ID value
[ "$distro_family" == 'unknown' ] &&  [ "$distro_id" != 'unknown' ] \
  && distro_family="$distro_id"

case $distro_family in

  'arch')
    distro_package_manager='pacman'
    [ "$distro_id" == 'antergos' ] \
    || [ "$distro_id" == 'arch' ] \
    || [ "$distro_id" == 'manjaro' ] \
    || warning 'Arch, Antergos and Manjaro are the only tested Arch variants. Experiences with other distros may vary. Caveat emptor.'
    ;;

  'fedora')
    distro_package_manager='dnf'
    [ "$distro_id" == 'fedora' ] \
    || [ "$distro_id" == 'korora' ] \
    || warning 'Fedora and Korora are the only tested Fedora variants. Experiences with other distros may vary. Caveat emptor.'
    ;;

  'unknown')
      die "Non-standard /etc/os-release file found - what crazy mong-arse distro are you on?"
      ;;

  #'ubuntu')
  #'debian')
  #'nixos')
  *)
    die "Detected $distro_name; $distro_family variants are not currently supported."
    ;;
esac

log "Distro: OK; detected: ${distro_name} (${distro_family} family)"

#######################################
#
#  Exports
#
#######################################

export DISTRO_ID=$distro_id
export DISTRO_FAMILY=$distro_family
export DISTRO_PACKAGE_MANAGER=$distro_package_manager

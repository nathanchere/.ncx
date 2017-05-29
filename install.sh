#!/usr/bin/env bash

# TODO:

# [DONE] detect environemnt (which package manager to use etc)
# config goes into ~/.config
# install dependencies (python etc)

function verboseOut {
	printf "\033[1;31m:: \033[0m$1\n"
}

function highlightOut {
	printf "\033[1;37m[[ \033[1;36m$1 \033[1;37m]] \033[0m$2\n"
}

function warnOut {
	printf "\033[1;37m[[ \033[1;33m! \033[1;37m]] \033[0m$1\n"
}

function errorOut {
	printf "\033[1;37m[[ \033[1;31m! \033[1;37m]] \033[0m$1\n"
}

function die {
	errorOut "$1"
  exit 1
}

function stderrOut {
	while IFS='' read -r line; do printf "\033[1;37m[[ \033[1;31m! \033[1;37m]] \033[0m${line}\n"; done
}

# Important stuff

distro='Unknown'

detectEnvironment () {

  highlightOut "*" "Checking distro"

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

  # Unknown or unsupported distros

  if [ "$distro_family" == 'Unknown' ]; then
    die "Unable to detect distro information; see README.md for supported distros"
  fi

  if [ "$distro_family" != 'arch' ] && [ "$distro_family" != 'fedora' ]; then
    die "${distro_name} is not supported; see README.md for supported distros"
  fi

  # Warnings for probably-safe-but-untested distros

  if [ "$distro_family" == 'arch' ] && [ "$distro_id" != 'antergos' ] && [ "$distro_id" != 'arch' ]; then
    warnOut 'Arch and Antergos are the only tested Arch variants. Experiences with other distros may vary. Caveat emptor.'
  fi

  if [ "$distro_family" == 'fedora' ] && [ "$distro_id" != 'fedora' ] && [ "$distro_id" != 'korora' ]; then
     warnOut 'Fedora and Korora are the only tested Fedora variants. Experiences with other distros may vary. Caveat emptor.'
  fi

  highlightOut "Detected: ${distro_name} (${distro_family} family)"

  distro=$distro_family
}

detectEnvironment

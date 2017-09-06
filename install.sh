#!/usr/bin/env bash

errorTrap() {
  printf "\n\033[91m*****************************************************************\033[0m\n\n\tError on %s\n\tSomething went wrong; Aboring...\n\n\033[91m*****************************************************************\033[0m\n\n" "$(caller)"
  exit
}
exitTrap() {
  printf "\n\033[1;37m[[ \033[1;31m! \033[1;37m]] \033[0m Script exited prematurely\n"
}
debugTrap() {
  printf "[ * ]\033[93m DEBUG: %s\033[0m [ * ]\n" "$(caller)"
}

if [ "${1:-}" == 'debug' ] ; then
  readonly DEBUG_MODE=true
  set -x
else
  readonly DEBUG_MODE=false
fi

trap errorTrap ERR
trap exitTrap EXIT
$DEBUG_MODE && trap debugTrap DEBUG

#######################################
#
#  .ncx Bootstrapper
#
# Installs the main `ncx` tool and dependencies
#
#######################################

. "system/_.sh"
. "system/_distro.sh"
. "system/_package.sh"

BIN_INSTALL_PATH="$HOME/.ncx/system/bin"
GLOBAL_PROFILE_FILE="ncx.profile.sh"

log ""
log "  **************************"
log " **                        **"
log "**    .ncx Bootstrapper     **"
log " **                        **"
log "  **************************"
log ""
log "  -- Logging to: $LOGFILE --\n"

#######################################
#
#  Pre-setup validation steps
#
#######################################

detectCorrectPath() {
  if [ "$NCXROOT" != "$(pwd)" ]; then
    log "Home: $HOME; running from $(pwd)"
    die ".ncx installer must be run from '\$HOME/.ncx'. Because reasons."
  fi
  log "Install path: OK; running from $(pwd)"
}

detectAlreadyInstalled() {
  if [ -f "$CONFIG_FILE" ]; then
    promptYesNo ".ncx has already been installed. Remove and re-install?" || die "Exiting..."
    cleanInstall
  else
    log "No prior install: OK"
  fi
}

#######################################
#
#  Main installation steps
#
#######################################

initConfigFile() {
  rm -f "$CONFIG_FILE"
  touch "$CONFIG_FILE"
  echo "distro=$DISTRO" >> "$CONFIG_FILE"
}

addExtraPaths() {
  log "Configuring \$PATH through $GLOBAL_PROFILE_FILE"
  rm -f "$GLOBAL_PROFILE_FILE"
  touch "/etc/profile.d/$GLOBAL_PROFILE_FILE"
  addToFileOnce "PATH=$BIN_INSTALL_PATH:$PATH" "/etc/profile.d/$GLOBAL_PROFILE_FILE"
  addToFileOnce "export PATH" "/etc/profile.d/$GLOBAL_PROFILE_FILE"
}

installPrereqs() {
  log "Installing prerequisite packages"
  # These should be the only packages to need installing outside ncx
  installPackage "GNU stow" stow stow
  installPackage "rsync" rsync rsync
  installPackage "curl" curl curl
}

installSoftware() {
  log "Installing software packages"
  installPackage "Python 3.x" python3 python
  installPackage "fish shell" fish fish
}

installUserConfig() {
  # add groups and rules for things like user backlight permissions
  rsync -avm "system/udev/" "/etc/udev/rules.d"
  gpasswd -a "$USERNAME" video

  #reload newly synced udev rules
  udevadm control --reload-rules
  udevadm trigger

  # set default shell to fish
  usermod -s /usr/bin/fish "$USERNAME"
  # install oh-my-fish
  curl -L https://get.oh-my.fish | fish
}

installNcxUtil () {
  ln -s "$HOME/.ncx/system/ncx" "/usr/bin/ncx"
}

finaliseInstallation() {
  echo "complete=1" >> "$CONFIG_FILE"
  log ".ncx bootstrap install complete!"
}

#######################################
#
#  Misc helpers
#
#######################################

cleanInstall() {
  log "Cleaning existing install..."
  log " * Removing old config file"
  rm -f "$CONFIG_FILE"
  log " * Removing profile.d entry"
  rm -rf "/etc/profile.d/$GLOBAL_PROFILE_FILE"
  log " * Removing ncx util from /usr/bin"
  rm -f "/usr/bin/ncx"
}

#######################################
#
#  Main
#
#######################################

if "${1:-}" = 'debug' ; then
  # just some misc debug helper stuff
  if false ; then
    echo "Exported distro is $DISTRO"
    # isPackageInstalled "git" && echo "git OK" || echo "git not OK"
    # isPackageInstalled "igit" && echo "igit OK" || echo "igit not OK"

    installedVersion igit
    installedVersion git

    installPackage "GNU stow" stow stow
    exit
  fi
fi

# Pre-install validations
requireRoot
detectAlreadyInstalled
detectCorrectPath

promptYesNo "Are you sure you want to run the installer?" || die "Exiting..."

initConfigFile
addExtraPaths
installPrereqs
installSoftware
installNcxUtil
installUserConfig
finaliseInstallation

trap - DEBUG
trap - EXIT

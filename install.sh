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
  echo "distro_id=$DISTRO_ID" >> "$CONFIG_FILE"
  echo "distro_family=$DISTRO_FAMILY" >> "$CONFIG_FILE"
  echo "distro_package_manager=$DISTRO_PACKAGE_MANAGER" >> "$CONFIG_FILE"
}

addExtraPaths() {
  log "Configuring \$PATH through $GLOBAL_PROFILE_FILE"

  profile_file="/etc/profile.d/$GLOBAL_PROFILE_FILE"

  # Re-initialise clean profile.d template
  rm -f "$profile_file"
  cp "system/profile.d/ncx.profile.sh" "$profile_file"

  # Add .ncx bin helpers/tools
  addToFileOnce "pathMungeBefore '$BIN_INSTALL_PATH'" "$profile_file"

  log "Sourcing profile.d to avoid restart"
  source "$profile_file"
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
  log "Configuring miscellaneous user settings"
  # add groups and rules for things like user backlight permissions
  rsync -avm "system/udev/" "/etc/udev/rules.d"
  gpasswd -a "$USERNAME" video

  #reload newly synced udev rules
  udevadm control --reload-rules
  udevadm trigger

  # set default shell to fish
  usermod -s /usr/bin/fish "$USERNAME"

  log "Configuring ohmyfish for $USERNAME"
  # install oh-my-fish

  OMF_INSTALLER="$TMPROOT/ohmyfi.sh"
  download "https://get.oh-my.fish" "$OMF_INSTALLER"
  su $USERNAME -c `fish "$OMF_INSTALLER"  --noninteractive`
  echo "TODO omf update"
}

installNcxUtil () {
  ln -s "$HOME/.ncx/system/ncx" "/usr/bin/ncx"
}

finaliseInstallation() {
  echo "complete=1" >> "$CONFIG_FILE"
  log ".ncx bootstrap install complete!"
  log "Your next terminal will be filled with joy"
  log "  ncx      to see fun stuff"
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
  log " * Removing ohmyfish"
  rm -rf "$HOME/.local/share/omf"
}

#######################################
#
#  Main
#
#######################################

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

#!/usr/bin/env bash

. "system/_.sh"
. "system/_.sh"

exit 11

# configure system stuff
# configure essentials e.g git omf
# verify install
# - and cleanup partial install on fail? overkill?
# mark and detect failed installs or incomplete installs via .config?

# standardise output (e.g. die format, headers etc)
# Add --force flag support to re-install

readonly LOG_FILE="/tmp/.log"


BIN_INSTALL_PATH="$HOME/.ncx/system/bin"
GLOBAL_PROFILE_FILE="ncx.profile.sh"
distro='Unknown'

echo -e "\n  **************************d"
echo -e " **                        **"
echo -e "**    .ncx Bootstrapper     **"
echo -e " **                        **"
echo -e "  **************************\n"

echo -e "  -- Logging to: $LOG_FILE --\n"

#######################################
#
#  Pre-setup validation steps
#
#######################################

detectUser () {
  if [[ -z $USERNAME ]]; then
    die "Unable to determine main username"
  fi

  # Must run as root
  if [ "$(whoami)" != "root" ]; then # Can also check $UID != 0
    die "This script requires root privilege. Try again with sudo."
  fi
}

detectEnvironment () {

  info "Checking distro"

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
    warning 'Arch and Antergos are the only tested Arch variants. Experiences with other distros may vary. Caveat emptor.'
  fi

  if [ "$distro_family" == 'fedora' ] && [ "$distro_id" != 'fedora' ] && [ "$distro_id" != 'korora' ]; then
     warning 'Fedora and Korora are the only tested Fedora variants. Experiences with other distros may vary. Caveat emptor.'
  fi

  info "Distro: OK; detected: ${distro_name} (${distro_family} family)"

  distro=$distro_family
}

detectCorrectPath() {
  if [ "$HOME/.ncx" != "$(pwd)" ]; then
    echo "Home is $HOME; running from $(pwd)"
    die ".ncx installer must be run from '\$HOME/.ncx'. Because reasons."
  fi
  info "Install path: OK; running from $(pwd)"
}

detectAlreadyInstalled() {
  if [ -f "$CONFIG_FILE" ]; then
    promptYesNo ".ncx has already been installed. Remove and re-install?" || die "Exiting..."
    cleanInstall
  else
    info "No prior install: OK"
  fi
}

confirmBeforeContinue() {
  promptYesNo "Are you sure you want to run the installer?" || die "Exiting..."
}

#######################################
#
#  Main installation steps
#
#######################################

initConfigFile() {
  rm -f "$CONFIG_FILE"
  touch "$CONFIG_FILE"
  echo "distro=$distro" >> "$CONFIG_FILE"
}

addExtraPaths() {
  info "Configuring \$PATH through $GLOBAL_PROFILE_FILE"
  rm -f "$GLOBAL_PROFILE_FILE"
  touch "/etc/profile.d/$GLOBAL_PROFILE_FILE"
  addToFileOnce "PATH=$BIN_INSTALL_PATH:$PATH" "/etc/profile.d/$GLOBAL_PROFILE_FILE"
  addToFileOnce "export PATH" "/etc/profile.d/$GLOBAL_PROFILE_FILE"
}

# $1: dnf package name
isPackageInstalledFedora() {
  echo "Checking for Fedora package '$1'"
  rpm -q "$1" &> /dev/null

  # note: shitty way of doing this. Will give potentially give false negative if any errors occur
  return $?
}

# $1: pacman package name
# TODO: how to check for non-pacman in arch, eg AUR
isPackageInstalledArch() {
  echo "Checking for Arch package '$1'"
  pacman -Q "$1" &> /dev/null

  # note: shitty way of doing this. Will give potentially give false negative if any errors occur
  return $?
}

# Meh, does the job
# $1: dnf package name
# $2: pacman package name
# $3: package description
installPackage() {
  if [ "$distro" == "fedora" ]; then
    if isPackageInstalledFedora "$1"; then
        log "Package $1 is already installed; skipping..."
       return
    fi
    log "Installing $1..."
    sudo dnf install -y $1
    return
  fi

  if [ "$distro" == "arch" ]; then
    if isPackageInstalledArch "$2" ]; then
        log "Package $2 is already installed; skipping..."
        return
    fi
    log "Installing $2..."
    sudo pacman --noconfirm -S $2
    return
  fi
}

installPrereqs() {
  info "Installing prerequisite packages"
  # These should be the only packages to need installing outside ncx
  installPackage stow stow "GNU stow"
  installPackage rsync rsync "rsync"
  installPackage curl curl "curl"
}

installSoftware() {
  info "Installing software packages"

  installPackage python3 python "Python 3.x"
  installPackage fish fish "fish shell"
}

installUserConfig() {
  # add groups and rules for things like user backlight permissions
  rsync -avm "system/udev/" "/etc/udev/rules.d"
  gpasswd -a "$USERNAME" video

  #reload newly synced udev rules
  udevadm control --reload-rules
  udevadm trigger
}


installNcxUtil () {
    ln -s "$HOME/.ncx/ncx" "/usr/bin/ncx"
}

finaliseInstallation() {
  echo "complete=1" >> "$CONFIG_FILE"
}

#######################################
#
#  Misc helpers
#
#######################################

cleanInstall() {
  info "Cleaning existing install..."
  log " * Removing old config file"
  rm -f "$CONFIG_FILE"
  log " * Removing profile.d entry"
  rm -rf "/etc/profile.d/$GLOBAL_PROFILE_FILE"
  log " * Removing ncx util from /usr/bin"
  rm -f "/usr/bin/ncx"
}



head() { echo -e "========================\n$@\n========================\n\n" | tee -a "$LOG_FILE" >&2 ; }
log()    { echo -e "$@" | tee -a "$LOG_FILE" >&2 ; }
info()    { echo -e "[INFO]    $@" | tee -a "$LOG_FILE" >&2 ; }
warning() { echo -e "[WARNING] $@" | tee -a "$LOG_FILE" >&2 ; }
error()   { echo -e "[ERROR]   $@" | tee -a "$LOG_FILE" >&2 ; }
die()   { echo -e "[FATAL]   $@" | tee -a "$LOG_FILE" >&2 ; exit 1 ; }

#######################################
#
#  Main
#
#######################################

# Pre-install validations

detectEnvironment
detectAlreadyInstalled
detectCorrectPath
confirmBeforeContinue

echo "Installing, hold on to your hats..."

initConfigFile
addExtraPaths
installPrereqs
installNcxUtil
installUserConfig

finaliseInstallation

cleanup() {
  echo Cleaning up
}
trap cleanup EXIT

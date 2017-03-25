#!/bin/bash

. "./_.sh"

requireRoot

latestTelegramUrl() {
  # Note: often includes pre-releases. Two url differs like so:
  # https://github.com/telegramdesktop/tdesktop/releases/download/v1.0.14/tsetup.1.0.14.tar.xz
  # https://github.com/telegramdesktop/tdesktop/releases/download/v1.0.25/tsetup.1.0.25.alpha.tar.xz
  # also 32 bit releases which we don't want:
  # https://github.com/telegramdesktop/tdesktop/releases/download/v1.0.14/tsetup32.1.0.14.tar.xz

  echo $(curl -sL "https://api.github.com/repos/telegramdesktop/tdesktop/releases/latest" | grep "https.*tsetup.*.tar.xz" | grep -v "alpha" | grep -v "tsetup32" | cut -d '"' -f 4)
}

installedTelegramVersion() {
  echo $(rpm -qi atom | grep "Version" | cut -d ':' -f 2 | cut -d ' ' -f 2)
}

latestTelegramVersion() {
  echo $(latestTelegramUrl | cut -d '/' -f 8 | sed 's/v//g' )
}

main() {
  drawSubhead "Checking installed vs latest Telegram versions"
  INSTALLEDVERSION=$(installedTelegramVersion)
  LATESTVERSION=$(latestTelegramVersion)

  if [ "$INSTALLEDVERSION" == "$LATESTVERSION" ]; then
    echo "Latest version $LATESTVERSION already installed; skipping..."
  else
    if [ "$INSTALLEDVERSION" == "" ]; then
      echo "No previous Telegram installation detected; installing $LATESTVERSION"
    else
      echo "Outdated version $INSTALLEDVERSION installed; updating to $LATESTVERSION"
    fi

    DOWNLOADURL=$(latestTelegramUrl)
    INSTALLER="$TMPROOT/telegram-$LATESTVERSION.tar.xz"
    rm -f "$INSTALLER"
    echo "Downloading from $DOWNLOADURL to $INSTALLER"
    download "$DOWNLOADURL" "$INSTALLER"

    drawSubhead "Extracting to /usr/local/bin"
    rm -rf "/usr/local/bin/Telegram"
    tar -Jvxf "$INSTALLER" -C "/usr/local/bin" "Telegram/Telegram"
    mv /usr/local/bin/Telegram/Telegram /usr/local/bin/telegram
    rm -r /usr/local/bin/Telegram
  fi
}

main 2>&1 |& tee -a "$LOGFILE"

#!/bin/bash

. "./_.sh"

requireRoot

latestElixirSourceUrl() {
  echo $(curl -sL "https://api.github.com/repos/elixir-lang/elixir/releases/latest" | grep tarball_url | cut -d '"' -f 4)
}

installedElixirVersion() {
  if [ -x /usr/local/bin/iex ]; then
    echo $(/usr/local/bin/iex -v | grep IEx | cut -d ' ' -f 2)
  else
    echo ""
  fi
}

latestElixirVersion() {
  echo $(curl -sL "https://api.github.com/repos/elixir-lang/elixir/releases/latest" | grep tag_name | cut -d 'v' -f 2 | cut -d '"' -f 1)
}

main() {
  drawSubhead "Checking installed vs latest Elixir versions"
  INSTALLEDVERSION=$(installedElixirVersion)
  LATESTVERSION=$(latestElixirVersion)

  if [ "$INSTALLEDVERSION" == "$LATESTVERSION" ]; then
    echo "Latest version $LATESTVERSION already installed; skipping..."
  else
    if [ "$INSTALLEDVERSION" == "" ]; then
      echo "No previous Elixir installation detected; installing $LATESTVERSION"
    else
      echo "Outdated version $INSTALLEDVERSION installed; updating to $LATESTVERSION"
    fi

    echo "Installing prerequisites"
    dnf install -y erlang

    DOWNLOADURL=$(latestElixirSourceUrl)
    INSTALLER="$TMPROOT/elixir-$LATESTVERSION.tar.gz"
    SOURCEDIR="$TMPROOT/elixir-src"
    rm -f "$INSTALLER"
    rm -rf "$SOURCEDIR"
    echo "Downloading from $DOWNLOADURL to $INSTALLER"
    download "$(latestElixirSourceUrl)" "$INSTALLER"

    echo "Extracting source tarball to $SOURCEDIR"
    mkdir -p "$SOURCEDIR"
    tar -zvxf "$INSTALLER" -C "$SOURCEDIR"

    echo "Building Elixir from source"
    cd "$SOURCEDIR"
    cd *
    make clean compile install
  fi
}

main 2>&1 |& tee -a "$LOGFILE"

#!/bin/sh

XMONAD_DIR=$HOME/.xmonad

# TODO: not sure if this is really needed... need to investigate
# recompile if broken shared libs after an upgrade
XMONAD_CUSTOM=$XMONAD_DIR/xmonad-$(uname -i)-linux
if [ -r $XMONAD_DIR/xmonad.hs -a -x $XMONAD_CUSTOM ]; then
  if ldd $XMONAD_CUSTOM | grep -q "not found"; then
    xmonad --recompile
  fi
fi

dunst &
notify-send "It's alive" &
xmonad

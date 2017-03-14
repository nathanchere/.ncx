#!/bin/bash

mkdir -p logs

stow --verbose=2 -d dotfiles -t ~ compton >> logs/dotfiles.log 2>&1

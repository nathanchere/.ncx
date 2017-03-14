#!/bin/bash

mkdir -p logs

stow --verbose=2 -d dotfiles -t ~ compton >> logs/stow.log 2>&1

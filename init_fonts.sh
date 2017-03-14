#!/bin/bash

mkdir -p logs

stow --verbose=2 -d dotfiles -t ~ fonts >> logs/fonts.log 2>&1
fc-cache -fv  2>&1

echo Fonts done


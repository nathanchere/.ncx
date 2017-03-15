#!/bin/bash
# Common config stuff

# Exit on the first failure - it's bulletproof or GTFO
set -e

# Error on referencing any undefined variables (sanity check)
set -u

# Tips from http://stackoverflow.com/a/25515370/243557

yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }

NCXROOT = $(pwd)

echo $NCXROOT

yell()

# TODO:  2>&1 | tee logs/install.log
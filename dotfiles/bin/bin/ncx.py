#!/usr/bin/python3

# start in default .ncx dir

class fg:
    black='\033[30m'
    red='\033[31m'
    green='\033[32m'
    orange='\033[33m'
    blue='\033[34m'
    purple='\033[35m'
    cyan='\033[36m'
    lightgrey='\033[37m'
    darkgrey='\033[90m'
    lightred='\033[91m'
    lightgreen='\033[92m'
    yellow='\033[93m'
    lightblue='\033[94m'
    pink='\033[95m'
    lightcyan='\033[96m'
    white='\033[97m'
class bg:
    black='\033[40m'
    red='\033[41m'
    green='\033[42m'
    orange='\033[43m'
    blue='\033[44m'
    purple='\033[45m'
    cyan='\033[46m'
    lightgrey='\033[47m'
class text:
    reset='\033[0m'
    bold='\033[01m'
    disable='\033[02m'
    underline='\033[04m'
    reverse='\033[07m'
    strikethrough='\033[09m'
    invisible='\033[08m'

import sys,re
import json
import urllib3
import subprocess

def install(**args):
  print(f"Installing: {fg.white}{args[0]}{colors.reset}" )

def wifi(**args):
  subprocess.call('nmcli', 'd w')

def sync(**args):
  print("Syncing settings...")

def help(**args):
    print(f"Usage: etc" )

if len(sys.argv) == 1:
    print("Showing help")
    exit(0)

valid_actions = ['install','sync','help','version', 'wifi']
action = sys.argv[1]
args = list(sys.argv)
args.pop(0)
args.pop(0)

if action in valid_actions:
    eval(action + "(args)")
    exit(0)

print("Invalid action: " + action)
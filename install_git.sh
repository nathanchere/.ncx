#!/bin/bash

. "./_.sh"

requireNotRoot

main() {
  # TODO: check if created
  ssh-keygen -t rsa -b 4096 -C "git@nathanchere.com.au"

  curl -u "nathanchere" \
   --data "{\"title\":\"`hostname`_`date +%Y%m%d`\",\"key\":\"`cat ~/.ssh/id_rsa.pub`\"}" \
   https://api.github.com/user/keys
}

main 2>&1 |& tee -a "$LOGFILE"

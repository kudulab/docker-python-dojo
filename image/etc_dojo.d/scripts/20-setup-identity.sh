#!/bin/bash -e

###########################################################################
# This file ensures files are mapped from dojo_identity into dojo_home.
# Fails if any required secret or configuration file is missing.
###########################################################################

if [ ! -d "${dojo_identity}/.ssh" ]; then
  mkdir -p ${dojo_home}/.ssh
else
  cp -r "${dojo_identity}/.ssh/" "${dojo_home}/"
  find ${dojo_home}/.ssh -name '*id_rsa*' -exec chmod -c 0600 {} \;
  find ${dojo_home}/.ssh -name '*id_rsa*' -exec chown dojo:dojo {} \;
fi
chown dojo:dojo ${dojo_home}/.ssh
chmod 0700 ${dojo_home}/.ssh

echo "StrictHostKeyChecking no
UserKnownHostsFile /dev/null
" > "${dojo_home}/.ssh/config"
chown dojo:dojo "${dojo_home}/.ssh/config"

if [ -f "${dojo_identity}/.gitconfig" ]; then
  cp -p "${dojo_identity}/.gitconfig" "${dojo_home}"
fi

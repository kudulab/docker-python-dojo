#!/bin/bash -e

###########################################################################
# This file ensures files are mapped from ide_identity into ide_home.
# Fails if any required secret or configuration file is missing.
###########################################################################

# obligatory directory, copy it with all the secrets, particulary id_rsa
if [ ! -d "${ide_identity}/.ssh" ]; then
  echo "${ide_identity}/.ssh does not exist"
  exit 1;
fi
if [ ! -f "${ide_identity}/.ssh/id_rsa" ]; then
  echo "${ide_identity}/.ssh/id_rsa does not exist"
  exit 1;
fi
cp -r "${ide_identity}/.ssh" "${ide_home}"
for id_rsa_file in "${ide_home}/.ssh/"*"id_rsa"; do
  chown ide:ide "${id_rsa_file}"
  chmod 0600 "${id_rsa_file}"
done

# we need to ensure that ${ide_home}/.ssh/config contains at least:
# StrictHostKeyChecking no
echo "StrictHostKeyChecking no
UserKnownHostsFile /dev/null

ForwardAgent yes
Host git.ai-traders.com
User git
Port 2222
IdentityFile ${ide_home}/.ssh/id_rsa

Host gogs.ai-traders.com
User git
Port 2222
IdentityFile ${ide_home}/.ssh/id_rsa
" > "${ide_home}/.ssh/config"

# not obligatory configuration file
if [ -f "${ide_identity}/.gitconfig" ]; then
  cp "${ide_identity}/.gitconfig" "${ide_home}"
fi

# 1. Ensure that after bash login pwd is /ide/work
# 2. Specify which devpi-server index to use. The `--set-cfg` option generates
# three files:
# http://doc.devpi.net/latest/quickstart-server.html
# http://doc.devpi.net/latest/quickstart-pypimirror.html#permanent-index-configuration-for-pip
# (locust) ide@ffa4af8f1c30:/ide/work$ cat ~/.pip/pip.conf
# [global]
# index_url = http://devpi.ai-traders.com/root/ait/+simple/
# trusted-host = devpi.ai-traders.com
# [search]
# index = http://devpi.ai-traders.com/root/ait/
# (locust) ide@ffa4af8f1c30:/ide/work$ cat ~/.pydistutils.cfg
# [easy_install]
# index_url = http://devpi.ai-traders.com/root/ait/+simple/
#
# (locust) ide@ffa4af8f1c30:/ide/work$ cat ~/.buildout/default.cfg
# [buildout]
# index = http://devpi.ai-traders.com/root/ait/+simple/
#
# Do not copy ~/.profile from $ide_identity, because it may reference sth not installed in
# this docker image.
touch "${ide_home}/.profile"
echo "devpi use --set-cfg --pip-set-trusted=yes http://devpi.ai-traders.com/root/ait/
devpi login --password '' root
cd ${ide_work}" > "${ide_home}/.profile"

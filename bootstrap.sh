#!/bin/bash
set -ex

DESIRED_SHELL="/bin/bash"

source utils.sh

OS_CODE=$(get_os_code)
if [[ $OS_CODE -eq 1 ]] ;
then
  source bootstrap_osx.sh
else
  echo "Bootstrap not possible on this OS"
  exit 1
fi

change_shell $DESIRED_SHELL

install_packages

install_apps

setup_direnvrc

source "$(link_bash_file)"
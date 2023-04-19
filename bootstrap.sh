#!/bin/bash
set -ex

DESIRED_SHELL="/bin/bash"

source "$(pwd)/utils.sh"

change_shell "$DESIRED_SHELL"

OS_CODE=$(get_os_code)
if [[ $OS_CODE -eq 1 ]]; then
	source "$HOME/dotfiles/osx/bootstrap.sh"
else
	echo "Bootstrap not possible on this OS"
	exit 1
fi

install_packages

install_apps

setup_direnv

_bash_file="$(link_bash_file)"

# shellcheck source=/dev/null
source "$HOME/${_bash_file}"

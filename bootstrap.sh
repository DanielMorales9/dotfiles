#!/bin/bash
set -ex

DESIRED_SHELL="/bin/bash"

source "$HOME/dotfiles/utils.sh"
source "$HOME/dotfiles/git/setup.sh"

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

setup_git_config

_bash_file="$(link_bash_file)"

# shellcheck source=/dev/null
source "$HOME/${_bash_file}"

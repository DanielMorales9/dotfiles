#!/bin/bash
set -ex

DESIRED_SHELL="/bin/zsh"

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

install_sdkman

setup_direnv

setup_git_config

_shell_rc="$(link_shell_rc "$DESIRED_SHELL")"

# validate with the shell being installed: bash cannot parse zsh syntax
"$DESIRED_SHELL" -c ". '${_shell_rc}'"

echo "Done. Open a new terminal (or run 'exec ${DESIRED_SHELL}') to pick up the new shell."

#!/bin/bash

function install_brew() {
	brew_url="https://raw.githubusercontent.com/Homebrew/install/master/install.sh"

	has_brew=$(exists "brew")
	# install brew on osx
	if [[ $has_brew -eq "0" ]]; then
		/bin/bash -c "$(curl -fsSL $brew_url)"
		export PATH="/opt/homebrew/bin:$PATH"
	fi
}

function install_packages() {
	install_brew

	# the -n guard keeps a file with no trailing newline from losing its last entry
	while IFS= read -r formula || [[ -n "$formula" ]]; do
		[[ -z "$formula" ]] && continue
		brew list "$formula" || brew install "$formula"
	done <"$(dirname "$0")/osx/formulas.list"
}

# sdkman has no brew formula, so it uses its own installer. rcupdate=false stops
# it appending an init block to the shell rc files, which are symlinks into this
# repo: zsh/tools.zsh and bash/tools.sh source sdkman themselves.
function install_sdkman() {
	if [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
		echo "sdkman already installed"
		return 0
	fi

	curl -s "https://get.sdkman.io?rcupdate=false" | bash
}

function install_apps() {
	# install apps
	while IFS= read -r app || [[ -n "$app" ]]; do
		[[ -z "$app" ]] && continue
		brew install --cask --appdir="/Applications" "$app"
	done <"$(dirname "$0")/osx/apps.list"
}

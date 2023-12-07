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

  while IFS= read -r formula; do
    brew list "$formula" || brew install "$formula";
  done < "$(dirname $0)/osx/formulas.list"
}

function install_apps() {
  # install cask
	brew tap homebrew/cask
	brew install cask

	# install apps
	while IFS= read -r app; do
		brew install --cask --appdir="/Applications" "$app"
	done < "$(dirname $0)/osx/apps.list"
}

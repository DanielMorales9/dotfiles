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

	formulas=(
		"git"
		"bash-completion@2"
		"direnv"
		"wget"
		"tree"
		"htop"
		"tfenv"
		"pre-commit"
		"coreutils"
		"pyenv"
		"virtualenv"
		"pyenv-virtualenv"
		"kubectl"
		"jump"
		"shfmt"
		"shellcheck"
		"minikube"
		"helm"
		"watch"
		"derailed/k9s/k9s"
		"docker"
	)

	# install formulas
	for formula in "${formulas[@]}"; do
		brew list "$formula" || brew install "$formula"
	done

	# install cask
	brew tap homebrew/cask
	brew install cask
}

function install_apps() {
	apps=(
	  "google-cloud-sdk"
	)

	# install apps
	for app in "${apps[@]}"; do
		brew install --cask --appdir="/Applications" "$app"
	done
}

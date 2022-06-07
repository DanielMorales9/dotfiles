#!/bin/bash

function install_brew() {
	brew_url="https://raw.githubusercontent.com/Homebrew/install/master/install.sh"

	has_brew=$(exists "brew")
	# install brew on osx
	if [[ ! $has_brew ]]; then
		/bin/bash -c "$(curl -fsSL $brew_url)"
	fi
}

function install_packages() {

	install_brew

	packages=(
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
		"openjdk@8"
		"apache-spark"
		"kubectl"
		"minikube"
		"docker"
		"docker-compose"
		"jump"
		"shfmt"
		"shellcheck"
	)

	# install packages
	for package in "${packages[@]}"; do
		brew install "$package"
	done

	# install cask
	brew tap homebrew/cask
	brew install cask
}

function install_apps() {
	apps=(
		"virtualbox"
		"docker"
	)

	# install apps
	for app in "${apps[@]}"; do
		brew install --cask --appdir="/Applications" "$app"
	done
}

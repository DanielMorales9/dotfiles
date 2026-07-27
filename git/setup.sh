#!/bin/bash

# True once a previous run has linked ~/.gitconfig here and produced both
# identity files. Those files hold real addresses, so they are not regenerated
# silently: re-running bootstrap should not prompt for them again.
function git_config_exists() {
	local git_dir="$1"

	[[ -L "$HOME/.gitconfig" && "$(readlink "$HOME/.gitconfig")" == "$git_dir/gitconfig" ]] &&
		[[ -s "$HOME/.gitconfig-work" && -s "$HOME/.gitconfig-play" ]]
}

function setup_git_config() {
	DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
	GIT_DIR="$DOTFILES_DIR/git"

	if [[ "$1" != "--force" ]] && git_config_exists "$GIT_DIR"; then
		echo "Git already configured; skipping (pass --force to redo it)"
		return 0
	fi

	ln -sf "$GIT_DIR/gitconfig" "$HOME/.gitconfig"

	read -rp "Enter your name [Daniel Morales]: " GIT_NAME
	GIT_NAME=${GIT_NAME:-Daniel Morales}

	read -rp "Enter your work email: " WORK_EMAIL
	read -rp "Enter your personal email [dnlmrls9@gmail.com]: " PERSONAL_EMAIL
	PERSONAL_EMAIL=${PERSONAL_EMAIL:-dnlmrls9@gmail.com}

	sed -e "s/Daniel Morales/$GIT_NAME/" \
		-e "s/WORK_EMAIL_PLACEHOLDER/$WORK_EMAIL/" \
		"$GIT_DIR/gitconfig-work.template" >"$HOME/.gitconfig-work"

	sed -e "s/Daniel Morales/$GIT_NAME/" \
		-e "s/PERSONAL_EMAIL_PLACEHOLDER/$PERSONAL_EMAIL/" \
		"$GIT_DIR/gitconfig-play.template" >"$HOME/.gitconfig-play"

	mkdir -p "$HOME/Projects/Work" "$HOME/Projects/Personal"

	echo "Git config linked. Work -> ~/Projects/Work, Personal -> ~/Projects/Personal"
}

#!/bin/sh
# Shared entrypoint for both shells. Detects the *running* shell and loads the
# matching directory, so ~/.zshrc and ~/.bash_profile can both symlink here.

_dotfiles_shell=""
_dotfiles_ext=""

if [ -n "$ZSH_VERSION" ]; then
	_dotfiles_shell="zsh"
	_dotfiles_ext="zsh"
elif [ -n "$BASH_VERSION" ]; then
	_dotfiles_shell="bash"
	_dotfiles_ext="sh"
else
	echo "dotfiles: only bash and zsh are configured; nothing loaded" >&2
fi

if [ -n "$_dotfiles_shell" ]; then
	DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

	# shell-agnostic first, so the shell-specific files below can override them
	for _dotfiles_part in functions aliases; do
		_dotfiles_file="$DOTFILES_DIR/shared/${_dotfiles_part}.sh"
		# shellcheck source=/dev/null
		[ -f "$_dotfiles_file" ] && . "$_dotfiles_file"
	done

	# envs before completion/tools, prompt last: bash's PS1 needs __git_ps1, which
	# completion.sh provides, and both shells want direnv/pyenv hooked up first
	for _dotfiles_part in envs aliases completion tools keybindings prompt; do
		_dotfiles_file="$DOTFILES_DIR/${_dotfiles_shell}/${_dotfiles_part}.${_dotfiles_ext}"
		# shellcheck source=/dev/null
		[ -f "$_dotfiles_file" ] && . "$_dotfiles_file"
	done

	# shellcheck source=/dev/null
	[ -f "$HOME/.private" ] && . "$HOME/.private"

	# zsh-only: print a random tip at the end of startup
	if [ "$_dotfiles_shell" = "zsh" ] && [ -t 1 ]; then
		_dotfiles_tipfile="$DOTFILES_DIR/zsh/tips.zsh"
		[ -f "$_dotfiles_tipfile" ] && . "$_dotfiles_tipfile"
	fi
fi

unset _dotfiles_shell _dotfiles_ext _dotfiles_part _dotfiles_file

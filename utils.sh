#!/bin/bash

function get_os_code() {
	unameOut="$(uname -s)"
	case "${unameOut}" in
	Darwin*) machine=1 ;;
	Linux*) machine=2 ;;
	*) machine=0 ;;
	esac
	echo ${machine}
}

function exists() {
	TRUE=1
	FALSE=0
	if ! command -v "$1" &>/dev/null; then
		echo "$FALSE"
	else
		echo "$TRUE"
	fi
}

function setup_direnv() {
	cat <<\EOF >~/.direnvrc
# use a certain pyenv version
use_python() {
    if [ -n "$(which pyenv)" ]; then
        local pyversion=$1
        pyenv local ${pyversion}
    fi
}

layout_virtualenv() {
    local pyversion=$1
    local pvenv=$2
    if [ -n "$(which pyenv virtualenv)" ]; then
        pyenv virtualenv --force --quiet ${pyversion} ${pvenv}-${pyversion}
    fi
    pyenv local --unset
}

layout_activate() {
    if [ -n "$(which pyenv)" ]; then
        source $(pyenv root)/versions/$1/bin/activate
    fi
}
EOF
}

# The rc file a shell reads on startup. bash splits login (.bash_profile, what
# OSX terminals open) from non-login (.bashrc); zsh uses .zshrc for both.
function get_shell_rc_name() {
	_shell_name="$(basename "$1")"
	if [[ "$_shell_name" == "zsh" ]]; then
		echo ".zshrc"
	elif [[ $(get_os_code) -eq 1 ]]; then
		echo ".bash_profile"
	else
		echo ".bashrc"
	fi
}

function change_shell() {
	DESIRED_SHELL=$1
	if [[ "$SHELL" != "$DESIRED_SHELL" ]]; then
		echo "Changing shell to $DESIRED_SHELL"
		chsh -s "$DESIRED_SHELL"
	fi
}

# Points the desired shell's rc file at init.sh, which then loads the matching
# bash/ or zsh/ directory. An rc file we do not own is left untouched: machine
# provisioned files often carry ordering-sensitive blocks (sdkman insists on being
# last), so this reports the line to add rather than rewriting the file.
function link_shell_rc() {
	_dotfiles_dir="$HOME/dotfiles"
	_rc_target="$_dotfiles_dir/init.sh"
	_rc_link="$HOME/$(get_shell_rc_name "$1")"

	if [[ -L "$_rc_link" ]]; then
		# readlink returns the target verbatim, which may be relative to the
		# link's own directory, so resolve it before deciding who owns it
		_rc_current="$(readlink "$_rc_link")"
		if [[ "$_rc_current" != /* ]]; then
			_rc_current="$(dirname "$_rc_link")/$_rc_current"
		fi

		if [[ "$_rc_current" == "$_rc_target" ]]; then
			: # already correct
		elif [[ "$_rc_current" == "$_dotfiles_dir"/* ]]; then
			# an earlier dotfiles layout owned this link, so repointing it is safe
			ln -sfn "$_rc_target" "$_rc_link"
			echo "Repointed $_rc_link -> $_rc_target" >&2
		else
			echo "WARNING: $_rc_link is a symlink outside dotfiles; leaving it alone" >&2
		fi
	elif [[ -e "$_rc_link" ]]; then
		echo "WARNING: $_rc_link already exists and is not managed by dotfiles." >&2
		echo "         Add this line to it to load the dotfiles config:" >&2
		echo "           source \"$_rc_target\"" >&2
	else
		ln -s "$_rc_target" "$_rc_link"
	fi

	echo "$_rc_target"
}

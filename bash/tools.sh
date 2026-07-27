#!/bin/bash

# Each hook names its shell explicitly. Leaving pyenv to autodetect breaks here:
# $SHELL is zsh once bootstrap has run, so pyenv would emit zsh code into bash.
# Each is guarded so a missing tool degrades quietly instead of breaking the shell.

# activate brew
command -v brew >/dev/null && eval "$(brew shellenv)"

# activate direnv
command -v direnv >/dev/null && eval "$(direnv hook bash)"

# activate jump
command -v jump >/dev/null && eval "$(jump shell bash)"

# activate pyenv ("init - bash" already puts the shims on PATH, so a separate
# "init --path" is redundant)
if command -v pyenv >/dev/null; then
	eval "$(pyenv init - bash)"

	# the virtualenv plugin is optional; resolve it in one shot
	_pyenv_virtualenv_init="$(pyenv virtualenv-init - bash 2>/dev/null)"
	[[ -n "$_pyenv_virtualenv_init" ]] && eval "$_pyenv_virtualenv_init"
	unset _pyenv_virtualenv_init
fi

# activate sdkman (requires bash 4+; macOS /bin/bash is 3.2)
if [[ ${BASH_VERSINFO[0]} -ge 4 ]] && [[ -f "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
	source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

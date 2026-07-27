#!/bin/zsh

# each hook is guarded so a missing tool degrades quietly instead of
# breaking every new shell

# activate brew
(( $+commands[brew] )) && eval "$(brew shellenv)"

# activate direnv
(( $+commands[direnv] )) && eval "$(direnv hook zsh)"

# activate jump
(( $+commands[jump] )) && eval "$(jump shell zsh)"

# activate pyenv ("init - zsh" already puts the shims on PATH, so the
# separate "init --path" the bash setup needed is redundant here)
if (( $+commands[pyenv] )); then
	eval "$(pyenv init - zsh)"

	# the virtualenv plugin is optional; resolve it in one shot
	_pyenv_virtualenv_init="$(pyenv virtualenv-init - zsh 2>/dev/null)"
	[[ -n "$_pyenv_virtualenv_init" ]] && eval "$_pyenv_virtualenv_init"
	unset _pyenv_virtualenv_init
fi

# activate sdkman
[[ -f "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

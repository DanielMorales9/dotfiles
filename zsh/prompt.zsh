#!/bin/zsh

setopt PROMPT_SUBST

# vcs_info replaces git-prompt.sh's __git_ps1
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true # bash: GIT_PS1_SHOWDIRTYSTATE
zstyle ':vcs_info:git:*' unstagedstr '*'
zstyle ':vcs_info:git:*' stagedstr '+'
zstyle ':vcs_info:git:*' formats '(%b%u%c)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'

autoload -Uz add-zsh-hook
add-zsh-hook precmd vcs_info

# Rosetta cannot change while the shell lives, so resolve it once here rather
# than forking sysctl on every redraw the way show_rosetta did.
typeset -g _ROSETTA_SEGMENT=''
if [[ "$(sysctl -n sysctl.proc_translated 2>/dev/null)" == 1 ]]; then
	_ROSETTA_SEGMENT=' %F{magenta}%B%URosetta%u%b%f'
fi

# bash equivalents: \t -> %*, \u@\h -> %n@%m, \w -> %~, \$ -> %#
PROMPT="\$(show_virtual_env)${_ROSETTA_SEGMENT} %F{yellow}[%*]%f %F{blue}%n@%m%f:%F{green}%~%f %B%F{magenta}\${vcs_info_msg_0_}%f%b%# "

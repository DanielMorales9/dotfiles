#!/bin/zsh

setopt PROMPT_SUBST
setopt TRANSIENT_RPROMPT  # clear RPROMPT after command acceptance (less clutter)

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

# show last exit code in red if non-zero, otherwise nothing
function _exit_code_segment() {
	local code=$?
	if [[ $code -ne 0 ]]; then
		echo " %F{red}[$code]%f"
	fi
}

# runtime of the previous command (only if > 3s)
typeset -g _CMD_START
typeset -g _CMD_RUNTIME_SEGMENT=''
function _record_cmd_start() {
	_CMD_START=$EPOCHREALTIME
}
function _show_cmd_runtime() {
	local secs=0
	if [[ -n "$_CMD_START" ]]; then
		secs=$(( ${EPOCHREALTIME%.*} - ${_CMD_START%.*} ))
	fi
	if [[ $secs -gt 3 ]]; then
		local mins=$(( secs / 60 ))
		local rem=$(( secs % 60 ))
		if (( mins > 0 )); then
			_CMD_RUNTIME_SEGMENT=" %F{cyan}${mins}m${rem}s%f"
		else
			_CMD_RUNTIME_SEGMENT=" %F{cyan}${secs}s%f"
		fi
	else
		_CMD_RUNTIME_SEGMENT=''
	fi
}
zmodload zsh/datetime
add-zsh-hook preexec _record_cmd_start
add-zsh-hook precmd _show_cmd_runtime

# bash equivalents: \t -> %*, \u@\h -> %n@%m, \w -> %~, \$ -> %#
PROMPT="\$(show_virtual_env)${_ROSETTA_SEGMENT}\${_CMD_RUNTIME_SEGMENT}\$(_exit_code_segment) %F{yellow}[%*]%f %F{blue}%n@%m%f:%F{green}%~%f %B%F{magenta}\${vcs_info_msg_0_}%f%b%# "

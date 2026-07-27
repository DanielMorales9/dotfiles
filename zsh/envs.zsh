#!/bin/zsh

# LS COLORS
export LSCOLORS=exfxcxdxbxegedabagacad
export CLICOLOR=1

# EDITOR
export EDITOR=/usr/bin/nano
export GIT_EDITOR=vim
export KUBE_EDITOR=vim

# Set default blocksize for ls, df, du
export BLOCKSIZE=1k

# HISTORY
HISTFILE="$HOME/.history"
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY      # bash: shopt -s histappend
setopt INC_APPEND_HISTORY  # write as commands run, not only at exit
setopt HIST_IGNORE_SPACE   # bash: HISTCONTROL=ignorespace
setopt HIST_IGNORE_ALL_DUPS # bash: HISTCONTROL=erasedups
setopt HIST_REDUCE_BLANKS
HISTORY_IGNORE='(ls|ps|history)' # bash: HISTIGNORE

# setting envs
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

export PYENV_VIRTUALENV_DISABLE_PROMPT=1

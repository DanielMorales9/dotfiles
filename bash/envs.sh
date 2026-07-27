#!/bin/bash

# LS COLORS
export LSCOLORS=exfxcxdxbxegedabagacad
export CLICOLOR=1

# EDITOR
export EDITOR=/usr/bin/nano

# Set default blocksize for ls, df, du
export BLOCKSIZE=1k

# HISTORY
export HISTFILE=$HOME/.history
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignorespace:erasedups
export HISTIGNORE="ls:ps:history"
shopt -s histappend

export GIT_EDITOR=vim

# SPARK_LATEST="3.2.1"
# JAVA_VERSION="1.8.0"

# setting envs
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
# export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"
# export PATH="/usr/local/opt/openjdk@8/bin:$PATH"
# export SPARK_HOME="/usr/local/Cellar/apache-spark/$SPARK_LATEST/libexec"
# JAVA_HOME=$(/usr/libexec/java_home -v "$JAVA_VERSION")
# export JAVA_HOME
export KUBE_EDITOR="vim"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

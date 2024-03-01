#!/bin/bash

# LS COLORS
export LSCOLORS=exfxcxdxbxegedabagacad
export CLICOLOR=1

# ANSI COLOR CODES
GREEN=$(ansi_color "32")
YELLOW=$(ansi_color "33")
# WHITE=$(ansi_color "97")
MAGENTA=$(ansi_color "35")
# B_MAGENTA=$(ansi_color "45")
# BLACK=$(ansi_color "33")
# RED=$(ansi_color "31")
BLUE=$(ansi_color "34")
RESET=$(ansi_color "0")
BOLD=$(ansi_color "1")
# DIM=$(ansi_color "2")
# UNDERLINED=$(ansi_color "4")

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

export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='$(show_virtual_env)${RESET}$(show_rosetta)${RESET} ${YELLOW}[\t]${RESET} ${BLUE}\u@\h${RESET}:${GREEN}\w ${BOLD}${MAGENTA}$(__git_ps1 "(%s)")${RESET}\$ '
export GIT_EDITOR=vim

# SPARK_LATEST="3.2.1"
# JAVA_VERSION="1.8.0"

# setting envs
export PATH="/opt/homebrew/bin:$PATH"
# export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"
# export PATH="/usr/local/opt/openjdk@8/bin:$PATH"
# export SPARK_HOME="/usr/local/Cellar/apache-spark/$SPARK_LATEST/libexec"
# JAVA_HOME=$(/usr/libexec/java_home -v "$JAVA_VERSION")
# export JAVA_HOME
export KUBE_EDITOR="vim"

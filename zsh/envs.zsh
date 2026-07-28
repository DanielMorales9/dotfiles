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
HISTSIZE=50000
SAVEHIST=50000
setopt APPEND_HISTORY       # bash: shopt -s histappend
setopt INC_APPEND_HISTORY   # write as commands run, not only at exit
setopt HIST_IGNORE_SPACE    # bash: HISTCONTROL=ignorespace
setopt HIST_IGNORE_ALL_DUPS # bash: HISTCONTROL=erasedups
setopt HIST_REDUCE_BLANKS   # trim extra whitespace from history entries
setopt HIST_VERIFY          # show `!!`/`!cmd` expansion before executing
setopt SHARE_HISTORY        # share history across concurrent shells
HISTORY_IGNORE='(ls|ps|history|exit|clear|pwd|cd)' # bash: HISTIGNORE

# DIRECTORY NAVIGATION
setopt AUTO_CD              # cd by typing a bare directory name
setopt AUTO_PUSHD           # `cd` pushes old dir onto the dir stack
setopt PUSHD_IGNORE_DUPS    # don't push duplicates onto the dir stack
setopt PUSHD_SILENT         # don't print the dir stack on pushd/popd

# GLOBBING
setopt EXTENDED_GLOB        # `^pattern`, `pattern~negpattern`, `(a|b)`
setopt NUMERIC_GLOB_SORT    # sort globbed files numerically (file2 before file10)
setopt NO_CASE_GLOB         # case-insensitive globbing (can be slow; remove if needed)

# JOB CONTROL
setopt NO_HUP               # don't kill background jobs on shell exit
setopt NO_CHECK_JOBS        # don't warn about running jobs on exit
setopt LONG_LIST_JOBS       # `jobs` shows PID, state, command by default

# INPUT/OUTPUT
setopt INTERACTIVE_COMMENTS # allow `#` comments in interactive shell
setopt NO_FLOW_CONTROL      # disable ^S/^Q flow control (frees those keys)
setopt RC_QUOTES            # allow `''` inside single quotes to mean a literal `'`

# CORRECTION
setopt CORRECT              # offer to correct misspelled commands

# setting envs
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

export PYENV_VIRTUALENV_DISABLE_PROMPT=1

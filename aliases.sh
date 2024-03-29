#!/bin/bash

alias ll='ls -la'   # list all
alias l.='ls -d .*' # hidden files

alias cd..='cd ../'              # Go back 1 directory level (for fast typers)
alias ..='cd ../'                # Go back 1 directory level
alias ...='cd ../../'            # Go back 2 directory levels
alias .3='cd ../../../'          # Go back 3 directory levels
alias .4='cd ../../../../'       # Go back 4 directory levels
alias .5='cd ../../../../../'    # Go back 5 directory levels
alias .6='cd ../../../../../../' # Go back 6 directory levels
alias ~="cd ~"                   # ~:            Go Home

# git aliases
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias gp='git push'
alias gpl='git pull'
alias gl='git log'
alias gf='git fetch'
alias gco='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'
alias gr='git rm'
alias gst='git stash'

# TODO this works only on OSX
alias da='direnv allow'
alias mvt='mvn -DskipTests'
alias tf='terraform'
alias k='kubectl'
alias pyop="open -a PyCharm"
alias suop="open -a Sublime\ Text"
alias txtop="open -a TextEdit"
alias bgop="open -g"


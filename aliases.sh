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
alias gpm='git pull origin master'
alias gl='git log'
alias gf='git fetch'
alias gfm='git fetch origin master'
alias gco='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'
alias gr='git rm'
alias gst='git stash'
alias gfm='git fetch origin master && git merge origin/master'

# TODO this works only on OSX
alias da='direnv allow'
alias mvt='mvn -DskipTests'
alias tf='terraform'
alias k='kubectl'
alias pyopen="open -a PyCharm"
alias suopen="open -a Sublime\ Text"
alias txtopen="open -a TextEdit"
alias jopen="open -a IntelliJ\ IDEA\ CE"
alias bgopen="open -g"
alias python="python3"
alias reload="source '$HOME/.bash_profile'"
alias rosetta="arch -x86_64 /bin/bash"

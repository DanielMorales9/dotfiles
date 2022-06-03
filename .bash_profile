# activate aliases
source "$HOME/dotfiles/aliases.sh"

# activate functions
source "$HOME/dotfiles/functions.sh"

# activate complet–ion
source "$HOME/dotfiles/bash_completion.sh"

# activate environments
source "$HOME/dotfiles/envs.sh"

# activate private
[[ -f "$HOME/.private" ]] && source "$HOME/.private"

# ANSI COLOR CODES
GREEN=$(ansi_color "32")
YELLOW=$(ansi_color "33")
WHITE=$(ansi_color "97")
MAGENTA=$(ansi_color "35")
B_MAGENTA=$(ansi_color "45")
BLACK=$(ansi_color "33")
RED=$(ansi_color "31")
BLUE=$(ansi_color "34")
RESET=$(ansi_color "0")
BOLD=$(ansi_color "1")
DIM=$(ansi_color "2")
UNDERLINED=$(ansi_color "4")

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
export PS1='${YELLOW}[\t]${RESET} ${BLUE}\u@\h${RESET}:${GREEN}\w ${BOLD}${MAGENTA}$(__git_ps1 "(%s)")${RESET}\$ '

# Enable Direnv Allow Hook
eval "$(direnv hook bash)"

# show virtualenv
PS1='$(show_virtual_env) '$PS1

# LS COLORS
export LSCOLORS=exfxcxdxbxegedabagacad
export CLICOLOR=1

# ANSI COLOR CODES
ansi-color() {
    CODE=$1
    OPEN_B="\001"
    CLOSE_B="\002"
    ANSI_ESC="\033["
    echo -e "${OPEN_B}${ANSI_ESC}${CODE}m${CLOSE_B}"
}

GREEN=$(ansi-color "32")
YELLOW=$(ansi-color "33")
WHITE=$(ansi-color "97")
MAGENTA=$(ansi-color "35")
BMAGENTA=$(ansi-color "45")
BLACK=$(ansi-color "33")
RED=$(ansi-color "31")
BLUE=$(ansi-color "34")
RESET=$(ansi-color "0")
BOLD=$(ansi-color "1")
DIM=$(ansi-color "2")
UNDERLINED=$(ansi-color "4")

# EDITOR
export EDITOR=/usr/bin/nano

# Set default blocksize for ls, df, du
export BLOCKSIZE=1k

# BASH COMPLETITION
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
[[ -f "/usr/local/share/git-completion.bash" ]] && . /usr/local/share/git-completion.bash
[[ -f "/usr/local/share/git-prompt.sh" ]] && . /usr/local/share/git-prompt.sh

export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='${YELLOW}[\t]${RESET} ${BLUE}\u@\h${RESET}:${GREEN}\w ${BOLD}${MAGENTA}$(__git_ps1 "(%s)")${RESET}\$ '

# Enable Direnv Allow Hook
eval "$(direnv hook bash)"

# activate aliases
source "$HOME/dotfiles/.aliases"

# activate private
[[ -f "$HOME/.private" ]] && source "$HOME/.private"

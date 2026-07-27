#!/bin/bash

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

# __git_ps1 comes from git-prompt.sh, sourced by completion.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='$(show_virtual_env)${RESET}$(show_rosetta)${RESET} ${YELLOW}[\t]${RESET} ${BLUE}\u@\h${RESET}:${GREEN}\w ${BOLD}${MAGENTA}$(__git_ps1 "(%s)")${RESET}\$ '

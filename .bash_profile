#!/bin/bash

# activate functions
source "$HOME/dotfiles/functions.sh"

# activate environments
source "$HOME/dotfiles/envs.sh"

# activate aliases
source "$HOME/dotfiles/aliases.sh"

# activate completion
source "$HOME/dotfiles/completion.sh"

# activate tools
source "$HOME/dotfiles/tools.sh"

# activate private
[[ -f "$HOME/.private" ]] && source "$HOME/.private"

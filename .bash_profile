# activate aliases
source "$HOME/dotfiles/aliases.sh"

# activate functions
source "$HOME/dotfiles/functions.sh"

# activate completion
source "$HOME/dotfiles/bash_completion.sh"

# activate tools
source "$HOME/dotfiles/tools.sh"

# activate environments
source "$HOME/dotfiles/envs.sh"

# activate private
[[ -f "$HOME/.private" ]] && source "$HOME/.private"
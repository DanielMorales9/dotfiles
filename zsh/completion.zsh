#!/bin/zsh

# Homebrew keeps its own and its formulas' zsh completions here (_git, _kubectl,
# _minikube, ...), so unlike the bash setup nothing has to be downloaded.
# fpath must be extended before compinit runs.
if (( $+commands[brew] )); then
	fpath=("$(brew --prefix)/share/zsh/site-functions" $fpath)
fi

# --- completion behaviour ---
setopt COMPLETE_IN_WORD    # complete from cursor position, not just at end
setopt ALWAYS_TO_END       # move cursor to end after completion
setopt AUTO_MENU           # show menu on second tab
setopt AUTO_LIST           # list ambiguous completions automatically
setopt NO_LIST_BEEP        # don't beep on ambiguous completion
setopt NO_MENU_COMPLETE    # first tab doesn't auto-insert; forces menu on second

# --- completion styling ---
zstyle ':completion:*' menu select                        # arrow-key navigation in menus
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"  # colour file completions like ls
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case-insensitive + partial match
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*'

# group completions by category with a label
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''

# sort completions numerically
zstyle ':completion:*' sort numeric

# cache completions for speed (esp. dpkg, brew, pip)
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zcompcache"

# verbose: show descriptions for completions
zstyle ':completion:*' verbose yes

# don't complete running processes for kill
zstyle ':completion:*:*:kill:*:processes' command 'ps -u $USER -o pid,comm -w'

# ssh hosts from known_hosts and config
if [[ -f ~/.ssh/known_hosts ]]; then
	_ssh_hosts=("${(@f)$(cut -d ' ' -f1 ~/.ssh/known_hosts 2>/dev/null)}")
	zstyle ':completion:*:ssh:*' hosts $_ssh_hosts
fi

# -i skips insecure (group-writable) directories instead of prompting about them
autoload -Uz compinit
compinit -i

# reuse kubectl's completion for the `k` alias (bash: complete -F __start_kubectl k)
(( $+commands[kubectl] )) && compdef k=kubectl

# --- history-incremental search (bound in keybindings.zsh) ---
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

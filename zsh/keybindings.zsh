#!/bin/zsh

# Use vi-like line editing keys in the standard keymap (emacs mode is still
# the default; these just add convenience bindings that work everywhere).

# Up/Down arrow: search history by prefix (set up in completion.zsh)
bindkey '^[[A' up-line-or-beginning-search    # Up arrow
bindkey '^[[B' down-line-or-beginning-search  # Down arrow
bindkey '^P'   up-line-or-beginning-search    # Ctrl-P
bindkey '^N'   down-line-or-beginning-search  # Ctrl-N

# Home / End / Delete (work on most terminals)
bindkey '^[[H'  beginning-of-line    # Home
bindkey '^[[F'  end-of-line          # End
bindkey '^[[3~' delete-char          # Delete
bindkey '^[[1~' beginning-of-line    # Home (xterm)
bindkey '^[[4~' end-of-line          # End (xterm)

# Ctrl-Left / Ctrl-Right: move by word
bindkey '^[[1;5D' backward-word      # Ctrl-Left
bindkey '^[[1;5C' forward-word       # Ctrl-Right
bindkey '^[[5D'   backward-word      # Alt-Left (fallback)
bindkey '^[[5C'   forward-word       # Alt-Right (fallback)

# Ctrl-Backspace: delete previous word
bindkey '^H' backward-kill-word

# Ctrl-Shift-Left/Right (some terminals): select-aware word movement
bindkey '^[[1;2D' backward-word
bindkey '^[[1;2C' forward-word

# Emacs-style bindings (already default, but explicit for clarity)
bindkey '^A' beginning-of-line       # Ctrl-A: start of line
bindkey '^E' end-of-line             # Ctrl-E: end of line
bindkey '^W' backward-kill-word      # Ctrl-W: delete word before cursor
bindkey '^U' backward-kill-line      # Ctrl-U: delete to start of line
bindkey '^K' kill-line               # Ctrl-K: delete to end of line
bindkey '^Y' yank                    # Ctrl-Y: paste killed text
bindkey '^_' undo                    # Ctrl-_: undo
bindkey '^X^E' edit-command-line     # Ctrl-X Ctrl-E: edit current line in $EDITOR

# edit-command-line: press Ctrl-X Ctrl-E to edit the current command line
# in your $EDITOR, save and quit, and the command executes.
autoload -Uz edit-command-line
zle -N edit-command-line

# Shift-Tab: reverse menu selection (cycle completions backwards)
bindkey '^[[Z' reverse-menu-complete
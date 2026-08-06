#!/bin/zsh

# zsh counterparts to the entries in bash/aliases.sh
alias reload='source "$HOME/.zshrc"'
alias rosetta="arch -x86_64 /bin/zsh"

# directory stack navigation
alias dh='dirs -v'         # show directory stack with indices
alias d1='cd +1'          # go back one dir in the stack
alias d2='cd +2'          # go back two dirs in the stack
alias d3='cd +3'          # go back three dirs in the stack

# history search (zsh-specific)
alias h='history'
alias hs='history | grep' # search history inline

# quick resource inspection
alias dfh='df -h | head -1 && df -h | grep -v "^map:"'  # human-readable disk, no devfs clutter
alias psg='ps aux | grep -v grep | grep'                 # find a process (without grep matching itself)

# safe defaults
alias cp='cp -i'  # confirm before overwriting
alias mv='mv -i'  # confirm before overwriting
alias rm='rm -i'  # confirm before deleting

# zsh globbing helpers
alias rmcrap='rm -f *.o *.a *.so *.class *~ .*.swp' # remove build artifacts
alias lsnew='ls -lt *(.om[1,8])'   # 8 most-recent files (zsh glob qualifiers)
alias lsold='ls -lt *(.Om[1,8])'   # 8 oldest files (zsh glob qualifiers)
alias lssize='ls -lhS *(.)'        # files sorted by size (non-recursive)

# misc
alias cat='bat --paging=never'
alias zshrc='${EDITOR:-vim} "$HOME/.zshrc"'
alias dotfiles='cd "$HOME/dotfiles"'

# suffix aliases — run a file directly by its extension, e.g. `./script.sh`
# or just `script.py`, and zsh opens it with the right program.
alias -s txt='open -a TextEdit'
alias -s md='bat --paging=never'
alias -s sh='zsh'
alias -s {yml,yaml}='bat --paging=never'
alias -s py='open -a "PyCharm"'
alias -s {java,gradle,xml,properties,scala,sbt}='open -a "IntelliJ IDEA"'
alias -s {zip,tar.gz,tgz,tbz2,tar.bz2,tar,rar,7z,gz,bz2,Z}='extract'
alias -s pdf='open -a Preview'
alias -s {html,htm}='open'

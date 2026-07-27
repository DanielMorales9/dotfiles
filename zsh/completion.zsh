#!/bin/zsh

# Homebrew keeps its own and its formulas' zsh completions here (_git, _kubectl,
# _minikube, ...), so unlike the bash setup nothing has to be downloaded.
# fpath must be extended before compinit runs.
if (( $+commands[brew] )); then
	fpath=("$(brew --prefix)/share/zsh/site-functions" $fpath)
fi

# -i skips insecure (group-writable) directories instead of prompting about them
autoload -Uz compinit
compinit -i

# reuse kubectl's completion for the `k` alias (bash: complete -F __start_kubectl k)
(( $+commands[kubectl] )) && compdef k=kubectl

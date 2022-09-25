#!/bin/bash

# bash completions
COMPLETION_DIR="$(brew --prefix)/etc/bash_completion.d"

function get_cmd_completion() {
	[[ ! -f "${COMPLETION_DIR}/$2" ]] && wget -O "${COMPLETION_DIR}/$2" "$1/$2"
}

function link_cmd_completion() {
	[[ ! -L "${COMPLETION_DIR}/$2" ]] && ln -s "$1/$2" "${COMPLETION_DIR}/$2"
}

# PREP WORK
# git completion preparation
_github_url="https://raw.githubusercontent.com/git/git/master/contrib/completion"
_git_prompt="git-prompt.sh"
_git_completion="git-completion.bash"

get_cmd_completion $_github_url $_git_prompt

get_cmd_completion $_github_url $_git_completion

# docker completion preparation
_docker_etc="/Applications/Docker.app/Contents/Resources/etc"
_docker="docker.bash-completion"
_docker_compose="docker-compose.bash-completion"

link_cmd_completion $_docker_etc $_docker

link_cmd_completion $_docker_etc $_docker_compose

# SOURCE COMPLETION
# git completion
# shellcheck source=/dev/null
source "${COMPLETION_DIR}/${_git_completion}"
# git prompt
# shellcheck source=/dev/null
source "${COMPLETION_DIR}/${_git_prompt}"

# docker completion
# shellcheck source=/dev/null
source "${COMPLETION_DIR}/${_docker}"
# docker-compose completion
# shellcheck source=/dev/null
source "${COMPLETION_DIR}/${_docker-compose}"

# kubectl completion
# shellcheck source=/dev/null
source "${COMPLETION_DIR}/kubectl"
complete -F __start_kubectl k

# minikube completion
# shellcheck source=/dev/null
source "${COMPLETION_DIR}/minikube"

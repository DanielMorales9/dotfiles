# BASH
COMPLETION_DIR="$(brew --prefix)/etc/bash_completion.d"

function get_github_completion() {
	github_url="https://raw.githubusercontent.com/git/git/master/contrib/completion"

	if [[ ! -f "${COMPLETION_DIR}/$1" ]] ;
	then
    	wget -O "${COMPLETION_DIR}/$1" "${github_url}/$1"
	fi
}

function get_docker_completion() {
	docker_etc="/Applications/Docker.app/Contents/Resources/etc"
	if [[ -d "${COMPLETION_DIR}" && ! -L "${COMPLETION_DIR}/$1" ]] ;
	then
  		ln -s "${docker_etc}/$1" "${COMPLETION_DIR}/$1"
	fi
}

# PREP WORK
# git completion preparation
_git_prompt="git-prompt.sh"
_git_completion="git-completion.bash"

get_github_completion $_git_prompt

get_github_completion $_git_completion


# docker completion preparation
_docker="docker.bash-completion"
_docker_compose="docker-compose.bash-completion"

get_docker_completion $_docker

get_docker_completion $_docker_compose


# SOURCE COMPLETION
# git completion
source "${COMPLETION_DIR}/${_git_completion}"
# git prompt
source "${COMPLETION_DIR}/${_git_prompt}"

# docker completion
source "${COMPLETION_DIR}/${_docker}"
# docker-compose completion
source "${COMPLETION_DIR}/${_docker-compose}"

# kubectl completion
source "${COMPLETION_DIR}/kubectl"
complete -F __start_kubectl k
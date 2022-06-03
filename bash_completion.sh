# BASH
COMPLETION_DIR="$(brew --prefix)/etc/bash_completion.d"
GITHUB_URL="https://raw.githubusercontent.com/git/git/master/contrib/completion"

# PREP WORK
# git completion preparation
_git_prompt="git-prompt.sh"
_git_completion="git-completion.bash"

if [[ ! -f "${COMPLETION_DIR}/${_git_completion}" ]] ;
then
    wget -O "${COMPLETION_DIR}/${_git_completion}" "${GITHUB_URL}/${_git_completion}"
fi

if [[ ! -f "${COMPLETION_DIR}/${_git_prompt}" ]] ;
then
    wget -O "${COMPLETION_DIR}/${_git_prompt}" "${GITHUB_URL}/${_git_prompt}"
fi

# docker completion preparation
docker_etc="/Applications/Docker.app/Contents/Resources/etc"
if [[ -d "${COMPLETION_DIR}" && ! -L "${COMPLETION_DIR}/docker" ]] ;
then
  ln -s "${docker_etc}/docker.bash-completion" "${COMPLETION_DIR}/docker"
fi

if [[ -d "${COMPLETION_DIR}" && ! -L "${COMPLETION_DIR}/docker-compose" ]] ;
then
  ln -s "${docker_etc}/docker-compose.bash-completion" "${COMPLETION_DIR}/docker-compose"
fi

# SOURCING COMPLETION

# git completion
source "${COMPLETION_DIR}/${_git_completion}"
# git prompt
source "${COMPLETION_DIR}/${_git_prompt}"

# docker completion
source "${COMPLETION_DIR}/docker"
# docker-compose completion
source "${COMPLETION_DIR}/docker-compose"

# kubectl completion
source "${COMPLETION_DIR}/kubectl"
complete -F __start_kubectl k

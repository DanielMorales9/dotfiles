# BASH
COMPLETION_DIR="$(brew --prefix)/etc/bash_completion.d"
GITHUB_URL="https://raw.githubusercontent.com"

# git completion
_git_base="git/git/master/contrib/completion"
_git_prompt="git-prompt.sh"
_git_completion="git-completion.bash"

if [[ ! -f "${COMPLETION_DIR}/${_git_completion}" ]] ;
then
    wget "${GITHUB_URL}/${_git_base}/${_git_completion}"
    mv "${_git_completion}" "${COMPLETION_DIR}/${_git_completion}"
fi

if [[ ! -f "${COMPLETION_DIR}/${_git_prompt}" ]] ;
then
    wget "${GITHUB_URL}/${_git_base}/${_git_prompt}"
    mv "${_git_prompt}" "${COMPLETION_DIR}/${_git_prompt}"
fi

# shellcheck disable=SC1090
. "${COMPLETION_DIR}/${_git_completion}"
# shellcheck disable=SC1090
. "${COMPLETION_DIR}/${_git_prompt}"

# docker completion
docker_etc="/Applications/Docker.app/Contents/Resources/etc"
if [[ ! -f "${COMPLETION_DIR}/docker.bash-completion" ]] ;
then
  ln -s "${docker_etc}/docker.bash-completion" "${COMPLETION_DIR}/docker"
fi

if [[ ! -f "${COMPLETION_DIR}/docker-compose.bash-completion" ]] ;
then
  ln -s "${docker_etc}/docker-compose.bash-completion" "${COMPLETION_DIR}/docker-compose"
fi

# shellcheck disable=SC1090
. "${COMPLETION_DIR}/docker"
# shellcheck disable=SC1090
. "${COMPLETION_DIR}/docker-compose"
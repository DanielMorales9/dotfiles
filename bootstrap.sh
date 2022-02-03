#!/bin/bash
set -ex

TRUE=0
FALSE=1
BREW_URL="https://raw.githubusercontent.com/Homebrew/install/master/install.sh"
DESIRED_SHELL="/bin/bash"

# TODO Refactor this into utils.bash
function get_os_code() {
    unameOut="$(uname -s)"
    case "${unameOut}" in
        Darwin*)    machine=1;;
        Linux*)     machine=2;;
        *)          machine=0
    esac
    echo ${machine}
}

function exists() {
    if ! command -v $1 &> /dev/null
    then
        exit $FALSE
    else
        exit $TRUE
    fi
}

if [[ "$SHELL" != "$DESIRED_SHELL" ]]
then
  echo "Changing shell to $DESIRED_SHELL"
  chsh -s "$DESIRED_SHELL"
fi

OS_CODE=$(get_os_code)

if [[ $OS_CODE -eq 0 ]] ;
then
  echo "Bootstrap not possible on this OS"
  exit 1
fi

has_brew=$(exists "brew")

# install brew on
if [[ $OS_CODE -eq 1 ]] && [[ $has_brew ]] ;
then
   /bin/bash -c "$(curl -fsSL $BREW_URL)"
fi

# install sw
if [[ $OS_CODE -eq 1 ]] ;
then
  brew install git bash-completion@2 direnv wget tree htop terraform coreutils pyenv virtualenv pyenv-virtualenv
fi

_bash_file=$( if [[ $OS_CODE -eq 1 ]] ; then echo ".bash_profile"; else echo ".bashrc"; fi )
[[ ! -f "$HOME"/"$_bash_file" ]] && ln -s "$HOME"/dotfiles/.bash_profile "$HOME"/"$_bash_file"

# shellcheck disable=SC1090
source "$HOME/${_bash_file}"

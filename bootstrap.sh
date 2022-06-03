#!/bin/bash
set -ex

TRUE=1
FALSE=0
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
        echo "$FALSE"
    else
        echo "$TRUE"
    fi
}

function setup_direnvrc() {
  cat <<\EOF >> ~/.direnvrc
# use a certain pyenv version
use_python() {
    if [ -n "$(which pyenv)" ]; then
        local pyversion=$1
        pyenv local ${pyversion}
    fi
}

layout_virtualenv() {
    local pyversion=$1
    local pvenv=$2
    if [ -n "$(which pyenv virtualenv)" ]; then
        pyenv virtualenv --force --quiet ${pyversion} ${pvenv}-${pyversion}
    fi
    pyenv local --unset
}

layout_activate() {
    if [ -n "$(which pyenv)" ]; then
        source $(pyenv root)/versions/$1/bin/activate
    fi
}
EOF
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

# install brew on osx
if [[ $OS_CODE -eq 1 ]] && [[ ! $has_brew  ]] ;
then
   /bin/bash -c "$(curl -fsSL $BREW_URL)"
fi

if [[ $OS_CODE -eq 1 ]] ;
then
  # install tools
  brew install git
  brew install bash-completion@2
  brew install direnv
  brew install wget
  brew install tree
  brew install htop
  brew install tfenv
  brew install pre-commit
  brew install coreutils
  brew install pyenv
  brew install virtualenv
  brew install pyenv-virtualenv
  brew install openjdk@8
  brew install apache-spark
  brew install kubectl
  brew install minikube

  # install cask
  brew tap homebrew/cask
  brew install cask

  # install apps
  # brew install --cask --appdir="/Applications" dropbox
  # brew install --cask --appdir="/Applications" docker
  # brew install --cask --appdir="/Applications" spotify
  brew install --cask --appdir="/Applications" virtualbox

fi

setup_direnvrc

_bash_file=$( if [[ $OS_CODE -eq 1 ]] ; then echo ".bash_profile"; else echo ".bashrc"; fi )
[[ ! -f "$HOME"/"$_bash_file" ]] && ln -s "$HOME"/dotfiles/.bash_profile "$HOME"/"$_bash_file"

# shellcheck disable=SC1090
source "$HOME/${_bash_file}"

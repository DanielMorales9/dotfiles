function install_brew() {
    BREW_URL="https://raw.githubusercontent.com/Homebrew/install/master/install.sh"

    HAS_BREW=$(exists "brew")
    # install brew on osx
    if [[ ! $HAS_BREW  ]] ;
    then
        /bin/bash -c "$(curl -fsSL $BREW_URL)"
    fi
}


function install_packages() {

  install_brew

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
}

function install_apps() {
  # install apps
  # brew install --cask --appdir="/Applications" dropbox
  # brew install --cask --appdir="/Applications" docker
  # brew install --cask --appdir="/Applications" spotify
  brew install --cask --appdir="/Applications" virtualbox

}
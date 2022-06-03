function install_brew() {
    brew_url="https://raw.githubusercontent.com/Homebrew/install/master/install.sh"

    has_brew=$(exists "brew")
    # install brew on osx
    if [[ ! $has_brew  ]] ;
    then
        /bin/bash -c "$(curl -fsSL $brew_url)"
    fi
}


function install_packages() {

  install_brew

  # install packages
  brew install git
  brew install docker
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
  brew install  
  brew install minikube
  brew install docker
  brew install docker-compose  

  # install cask
  brew tap homebrew/cask
  brew install cask
}

function install_apps() {
  # brew install --cask --appdir="/Applications" dropbox
  # brew install --cask --appdir="/Applications" spotify
  brew install --cask --appdir="/Applications" virtualbox

}
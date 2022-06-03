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
    TRUE=1
    FALSE=0
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

function get_bash_file() {
    OS_CODE=$(get_os_code)
  if [[ $OS_CODE -eq 1 ]] ; 
  then 
    echo ".bash_profile"; 
  else 
    echo ".bashrc"; 
  fi
}

function change_shell() {
    if [[ "$SHELL" != "$DESIRED_SHELL" ]] ; 
    then
        echo "Changing shell to $DESIRED_SHELL"
        chsh -s "$DESIRED_SHELL"
    fi
}

function link_bash_file() {

    _bash_file=$(get_bash_file)
    [[ ! -f "$HOME"/"$_bash_file" ]] && ln -s "$HOME"/dotfiles/.bash_profile "$HOME"/"$_bash_file"
}


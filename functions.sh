#!/bin/bash

function trash() { command mv "$@" ~/.Trash; }  # trash:        Moves a file to the MacOS trash
function ql() { qlmanage -p "$*" >&/dev/null; } # ql:           Opens any file in MacOS Quicklook Preview
function zipf() { zip -r "$1".zip "$1"; }       # zipf:         To create a ZIP archive of a folder

# extract:  Extract most know archives with one command
function extract() {
	if [ -f "$1" ]; then
		case "$1" in
		*.tar.bz2) tar xjf "$1" ;;
		*.tar.gz) tar xzf "$1" ;;
		*.bz2) bunzip2 "$1" ;;
		*.rar) unrar e "$1" ;;
		*.gz) gunzip "$1" ;;
		*.tar) tar xf "$1" ;;
		*.tbz2) tar xjf "$1" ;;
		*.tgz) tar xzf "$1" ;;
		*.zip) unzip "$1" ;;
		*.Z) uncompress "$1" ;;
		*.7z) 7z x "$1" ;;
		*) echo "$1 cannot be extracted via extract()" ;;
		esac
	else
		echo "$1 is not a valid file"
	fi
}

# prefixes git commits with ticket name
function prepare_commit_msg {
  GIT_HOOK_FILE="$(git rev-parse --show-toplevel)/.git/hooks/prepare-commit-msg"

  if [ -f "$GIT_HOOK_FILE" ]; then
    echo "Git Hook 'prepare-commit-msg' already exists"
  else
    touch prefix

    cat <<\EOF >>prefix
#!/bin/bash
FILE="$1"
MESSAGE=$(cat $FILE)
TICKET=$(git rev-parse --abbrev-ref HEAD | grep -Eo '^(\w+/)?(\w+[-])?[0-9]+' | grep -Eo '(\w+[-])?[0-9]+' | tr "[:lower:]" "[:upper:]")
if [[ $TICKET == "" || "$MESSAGE" == "$TICKET"* ]]; then
  exit 0;
fi
echo "$TICKET $MESSAGE" > $FILE
EOF

    chmod +x prefix
    mv prefix "$GIT_HOOK_FILE"
  fi
}

DEFAULT_PY_VERSION=3.11.6
function init_direnv {
	if [[ -z "$1" ]]; then
		version="$DEFAULT_PY_VERSION"
	else
		version="$1"
	fi

	if [[ -z "$2" ]]; then
		name=$(basename "$(pwd)")
	else
		name="$2"
	fi

	# writes a envrc file
	cat <<\EOF >.envrc
EOF

	cat <<EOF >>.envrc
py_version=${version}
pv_env=${name}

EOF

	cat <<\EOF >>.envrc
use python ${py_version}
# Create the virtualenv if not yet done
layout virtualenv ${py_version} ${pv_env}
# activate it
layout activate ${pv_env}-${py_version}
EOF

	# ignores .envrc file
	# temp disabled
	# printf "\n.envrc" >>.gitignore

}

# inits project with useful stuff
function pinit {
	# git prefix commits
	prepare_commit_msg

	# setup envrc
	init_direnv "$@"
}

function show_virtual_env() {
	if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
		echo "($(basename "$VIRTUAL_ENV"))"
	fi
}

function ansi_color() {
	_code="$1"
	OPEN_B="\001"
	CLOSE_B="\002"
	ANSI_ESC="\033["
	echo -e "${OPEN_B}${ANSI_ESC}${_code}m${CLOSE_B}"
}

function restart_terminal() {
  source "$HOME/.bash_profile"
}


function repeat() {
	local start=0
	local end=${1:-1}
	local str="${2:-#}"
	for _ in $(seq $start $end) ; do echo -n "${str}"; done
}


function print_progress_bar() {
  count=$1
  length=$2
  size=$3
  progress=$((count*100/length));

  num_hashes=$(( size * progress / 100));
  num_spaces=$((size - num_hashes))
  progress_bar=$(repeat $num_hashes "=")
  space_bar=$(repeat $num_spaces " ")
  percentage=$((progress));
  echo " $progress_bar>$space_bar ($percentage%)"
}

function date () {
  if type -p gdate > /dev/null; then
      gdate "$@";
  else
      date "$@";
  fi
}

function filter () {
  local function_to_apply="$1"
  local arg
  while read -r arg; do
    "$function_to_apply" "$arg" && echo "$arg"
  done
}
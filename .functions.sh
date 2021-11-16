trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview
zipf () { zip -r "$1".zip "$1" ; }          # zipf:         To create a ZIP archive of a folder

# extract:  Extract most know archives with one command
extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

# prefixes git commits with ticket name
function prefix {
    touch prefix

    cat <<\EOF >> prefix
#!/bin/bash
FILE=$1
MESSAGE=$(cat $FILE)
TICKET=$(git rev-parse --abbrev-ref HEAD | grep -Eo '^(\w+/)?(\w+[-])?[0-9]+' | grep -Eo '(\w+[-])?[0-9]+' | tr "[:lower:]" "[:upper:]")
if [[ $TICKET == "" || "$MESSAGE" == "$TICKET"* ]]; then
  exit 0;
fi
echo "$TICKET $MESSAGE" > $FILE
EOF

    chmod +x prefix
    mv prefix .git/hooks/prepare-commit-msg
}

# brings you back to project root
function proot {
  if [[ -z "${ROOT}" ]]; then
    echo "No Project Directory Root found. Ensure ROOT environment variable is set"
  else
    cd "${ROOT}"
  fi
}

# inits project with useful stuff
function pinit {
  prefix
  # writes a envrc file
  cat <<\EOF > .envrc
export ROOT="$(pwd)"
EOF

  # ignores .envrc file
  printf "\n.envrc" >> .gitignore

}
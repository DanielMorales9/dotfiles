#!/bin/bash

function setup_git_config() {
    DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
    GIT_DIR="$DOTFILES_DIR/git"

    ln -sf "$GIT_DIR/gitconfig" "$HOME/.gitconfig"

    read -p "Enter your name [Daniel Morales]: " GIT_NAME
    GIT_NAME=${GIT_NAME:-Daniel Morales}

    read -p "Enter your work email: " WORK_EMAIL
    read -p "Enter your personal email [dnlmrls9@gmail.com]: " PERSONAL_EMAIL
    PERSONAL_EMAIL=${PERSONAL_EMAIL:-dnlmrls9@gmail.com}

    sed -e "s/Daniel Morales/$GIT_NAME/" \
        -e "s/WORK_EMAIL_PLACEHOLDER/$WORK_EMAIL/" \
        "$GIT_DIR/gitconfig-work.template" > "$HOME/.gitconfig-work"

    sed -e "s/Daniel Morales/$GIT_NAME/" \
        -e "s/PERSONAL_EMAIL_PLACEHOLDER/$PERSONAL_EMAIL/" \
        "$GIT_DIR/gitconfig-play.template" > "$HOME/.gitconfig-play"

    mkdir -p "$HOME/Projects/Work" "$HOME/Projects/Personal"

    echo "Git config linked. Work -> ~/Projects/Work, Personal -> ~/Projects/Personal"
}
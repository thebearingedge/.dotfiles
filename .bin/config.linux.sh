#!/bin/sh

set -eu

git_dir="$HOME/.dotfiles.git"
backup_dir="$HOME/.dotfiles.bak"

dot() {
  /usr/bin/git --git-dir="$git_dir" --work-tree="$HOME" "$@"
}

config() {

  if [ -d "$git_dir" ]; then
    echo "$git_dir already exists... exiting" >&2
    exit 1
  fi

  if ! command -v git; then
    echo 'git is required to run this script' >&2
    exit 1
  fi

  echo 'cloning dotfiles...'
  git clone --bare \
    git@github.com:thebearingedge/.dotfiles.git \
    "$git_dir"

  if dot checkout != 0; then
    echo "backing up displaced dot files to $backup_dir..."
    mkdir -p "$backup_dir"
    dot checkout 2>&1 |
      grep -e "\s+\." |
      awk '{print $1}' |
      xargs -I {} mv {} "$backup_dir/{}"
  fi

  dot checkout
  dot config status.showUntrackedFiles no

  echo "dotfiles installed"
}

config

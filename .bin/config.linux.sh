#!/bin/sh

set -eu

git_dir="$HOME/.dotfiles.git"
backup_dir="$HOME/.dotfiles.bak"

dot() {
  /usr/bin/git --git-dir="$git_dir" --work-tree="$HOME" "$@"
}

config() {

  if ! command -v git; then
    echo 'git is required to run this script' >&2
    exit 1
  fi

  if [ ! -d "$git_dir" ]; then
    echo 'cloning dotfiles...'
    git clone --bare \
      https://github.com/thebearingedge/.dotfiles.git \
      "$git_dir"
  fi

  dot checkout || {
    echo "backing up displaced dot files to $backup_dir..."
    mkdir -p "$backup_dir"
    dot checkout 2>&1 |
      grep -e '^[[:space:]]\.' |
      awk '{print $1}' |
      xargs -I % sh -c "mkdir -p $(realpath "$backup_dir/$(dirname %)"); mv % $backup_dir/%" ||
      true
    find "$backup_dir"
  }

  dot checkout
  dot config status.showUntrackedFiles no

  echo "dotfiles installed"
}

config

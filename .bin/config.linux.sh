#!/bin/sh

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

  if ! dot checkout > /dev/null 2>&1; then
    echo "backing up displaced dot files to $backup_dir..."
    files="$(dot checkout 2>&1 | grep -e '^[[:space:]]\.' | awk '{print $1}')"
    for f in $files; do
      echo "creating $backup_dir/$f"
      mkdir -p "$backup_dir/$(dirname "$f")"
      mv "$f" "$backup_dir/$f"
    done
  fi

  dot checkout &&
  dot config status.showUntrackedFiles no &&

  echo "dotfiles installed"
}

config

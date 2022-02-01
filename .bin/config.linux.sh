#!/bin/sh

git_dir="$HOME/.dotfiles.git"
work_tree="$HOME"
backup_dir="$HOME/.dotfiles.bak"

https_url='https://github.com/thebearingedge/.dotfiles.git'
ssh_url='git@github.com:thebearingedge/.dotfiles.git'

dot() {
  /usr/bin/git --git-dir="$git_dir" --work-tree="$work_tree" "$@"
}

config() {

  if ! command -v git; then
    echo 'git is required to run this script' >&2
    exit 1
  fi

  if [ ! -d "$git_dir" ]; then
    echo 'cloning bare dotfiles repository ...'
    git clone --bare "$https_url" "$git_dir"
    dot config status.showUntrackedFiles no
    dot remote set-url --push origin "$ssh_url"
  fi

  files="$(dot checkout 2>&1 | grep -e '^[[:space:]]\.' | awk '{print $1}')"

  if [ -n "$files" ]; then
    echo "backing up displaced dotfiles to $backup_dir ..."
    for f in $files; do
      echo "$backup_dir/$f"
      mkdir -p "$(dirname "$backup_dir/$f")"
      mv "$f" "$backup_dir/$f"
    done
    unset f
    dot checkout
  fi

  echo "dotfiles installed"
}

config

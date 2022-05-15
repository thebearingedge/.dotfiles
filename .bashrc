#!/usr/bin/env bash

# don't load anything for non-interactive shells
[[ $- != *i* ]] && return

# load bash settings for interactive shells
if [ -d ~/.bashrc.d ]; then
  for f in ~/.bashrc.d/*; do
    # shellcheck source=/dev/null
    [ -x "$f" ] && source "$f"
  done
  unset f
fi

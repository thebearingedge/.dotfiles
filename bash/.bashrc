#!/usr/bin/env bash

# don't load anything for non-interactive shells
[[ $- != *i* ]] && return

# load bash settings for interactive shells
[[ -d ~/.bashrc.d ]] || return
for f in ~/.bashrc.d/*; do
  # shellcheck source=/dev/null
  [ -x "$f" ] && source "$f"
done
unset f

#!/usr/bin/env bash

# shellcheck source=/dev/null
[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ -z "$DISPLAY" ]] && [[ "$(tty)" = /dev/tty1 ]]; then
  exec startx
fi

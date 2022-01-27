#!/usr/bin/env bash

# shellcheck source=/dev/null
[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ -z "$DISPLAY" ]] && [[ "$(tty)" = /dev/tty1 ]]; then
  clear
  exec startx > /dev/null 2>&1
fi

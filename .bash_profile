#!/usr/bin/env bash

if [ -z "$DISPLAY" ] && [ "$(basename "$(tty)")" = 'tty1' ]; then
  # load graphical environment
  clear
  sway > /dev/null 2>&1
else
  # load shell environment
  # shellcheck source=/dev/null
  [ -f ~/.bashrc ] && source ~/.bashrc
fi

#!/bin/sh

if [ -f ~/.Xresources ]; then
  xrdb -merge ~/.Xresources
fi

# load system configs
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    # shellcheck source=/dev/null
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# load my configs
if [ -d ~/.xinitrc.d ]; then
  for f in ~/.xinitrc.d/*; do
    # shellcheck source=/dev/null
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# start window manager
exec i3

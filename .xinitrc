#!/bin/sh
#
# ~/.xinitrc

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

systemctl --user import-environment DISPLAY
systemctl --user import-environment PATH
~/.fehbg &
taffybar &
# network
nm-applet &
# volume
volctl &
caffeine &
# fix default x cursor
xsetroot -cursor_name left_ptr
# screensaver and locking
#   5 min screen lock delay
xset s 300
#   xss-lock with my i3lock-fancy lock script. Also listens for suspends
xss-lock -l -- .local/bin/transfer-sleep-lock-i3lock.sh &

xmonad

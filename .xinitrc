#!/bin/sh

setxkbmap dvorak &

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
pipewire-volumeicon-launcher &
sxhkd &
feh --bg-fill ~/wallpapers/dark/002.jpg &
dex -a -s /etc/xdg/autostart/:~/.config/autostart/

# exec dwm
# exec herbstluftwm
exec awesome

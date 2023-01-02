#!/bin/sh

setxkbmap dvorak &

xrandr --output eDP-1 --mode 1920x1080
xrandr --output HDMI-1 --mode 1920x1080 --right-of eDP-1

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
pipewire-volumeicon-launcher &
sxhkd &
feh --bg-fill ~/wallpapers/dark/002.jpg &
dex -a -s /etc/xdg/autostart/:~/.config/autostart/

# Default
session=${1:-awesome}

case $session in
    awesome             ) exec awesome;;
    dwm                 ) exec dwm;;
    hlwm|herbstluftwm   ) exec herbstluftwm;;
    # No known session, try to run it as command
    *                 ) exec $1;;
esac

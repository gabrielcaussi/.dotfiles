#!/bin/sh

xrandr --auto
xrandr --dpi 96

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

xsetroot -cursor_name left_ptr

exec dbus-launch --autolaunch=$(cat /var/lib/dbus/machine-id) bspwm


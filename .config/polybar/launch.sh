#!/usr/bin/env sh

#========< Terminate already running bar instances >============================
killall -q polybar

#========< Wait until the processes have been shut down >=======================
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

#========< Launch Top Bar and Bottom Bar >======================================
polybar -c ~/.config/polybar/config.ini top -r &
polybar -c ~/.config/polybar/config.ini bottom -r &

#!/bin/bash

xrdb -merge .Xresources

# Set up an icon tray
trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 10 --transparent true --alpha 0 --tint 0x444444 --height 19

# Set the background color
#xsetroot -solid black
#/usr/bin/stalonetray &

gnome-screensaver &
pidof update-notifier || update-notifier --force-use-gksu --startup-delay 60 &

if [ -x /usr/bin/gnome-power-manager ] ; then
   sleep 1
   gnome-power-manager &
fi

#if [ -x /usr/bin/nm-applet ] ; then
#   nm-applet --sm-disable &
#fi

/usr/bin/gnome-sound-applet &

eval $(gnome-keyring-daemon --start)
export GNOME_KEYRING_SOCKET
export GNOME_KEYRING_PID

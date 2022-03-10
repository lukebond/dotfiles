#!/bin/bash
xrandr --addmode eDP-1 2560x1440
xrandr --output eDP-1 --mode 2560x1440 --output DP-2 --mode 2560x1440 --above eDP-1

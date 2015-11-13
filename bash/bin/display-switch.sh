#!/bin/bash
if ! xrandr | grep VGA1 | grep disconnected  &gt;/dev/null ; then
  xrandr --output LVDS1 --mode 1024x768 --output VGA1 --mode 1920x1080 --above LVDS1
else
  xrandr --auto
fi

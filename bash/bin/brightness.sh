#!/bin/bash
case "$1" in
  "max" )
    echo "24242" > /sys/class/backlight/intel_backlight/brightness;;
  "dim" )
    echo "2424" > /sys/class/backlight/intel_backlight/brightness;;
esac

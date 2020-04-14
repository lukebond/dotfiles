#!/bin/bash
case "$1" in
  "inc" )
    xbacklight -inc 5;;
  "dec" )
    xbacklight -dec 5;;
esac

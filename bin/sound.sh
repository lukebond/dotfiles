#!/bin/bash
case "$1" in
  "up" )
    ponymix increase 1;;
  "down" )
    ponymix decrease 1;;
  "mute" )
    ponymix toggle;;
esac

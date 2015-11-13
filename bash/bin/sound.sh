#!/bin/bash

STEP="1"    # Anything you like.
SETVOL="/usr/bin/ponymix"

case "$1" in
    "up")
          $SETVOL increase $STEP
          ;;
  "down")
          $SETVOL decrease $STEP
          ;;
  "mute")
          $SETVOL toggle
          ;;
esac

exit 0

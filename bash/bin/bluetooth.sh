#!/bin/bash
source ~/.local/bin/.bluetooth-devices
DEVICE="${DEVICE:-headphones}"
case "${DEVICE}" in
  speaker)
    DEVICE="${DEVICE_SPEAKER}"
    ;;
  plt)
    DEVICE="${DEVICE_PLT}"
    ;;
  headphones)
    DEVICE="${DEVICE_HEADPHONES}"
    ;;
  logitech)
    DEVICE="${DEVICE_LOGITECH}"
    ;;
  *)
    echo "Unsupported device>" && exit 1
esac
bluetoothctl power on > /dev/null
if [[ "${#}" -gt 0 ]] && [[ "${1}" == "status" ]]; then
  bluetoothctl info "${DEVICE}" | grep 'Connected: yes' > /dev/null
  exit
elif [[ "${#}" -gt 0 ]] && [[ "${1}" == "disconnect" ]]; then
  bluetoothctl disconnect "${DEVICE}" > /dev/null
  exit
fi
# connect
bluetoothctl connect "${DEVICE}"

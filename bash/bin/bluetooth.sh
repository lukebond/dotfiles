#!/bin/bash
source ~/bin/.bluetooth-devices
DEVICE="${DEVICE:-headphones}"
case "${DEVICE}" in
  speaker)
    DEVICE="${DEVICE_SPEAKER}"
    ;;
  headphones)
    DEVICE="${DEVICE_HEADPHONES}"
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

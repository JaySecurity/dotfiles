#!/usr/bin/env bash

CURRENT_PORT=$(pactl list sinks | grep "Active Port" | sed "s/\tActive Port: //" | sed -n -e 's/.*\(analog-output-\(lineout\|headphones\)\).*/\1/p')

echo $CURRENT_PORT

if [[ "$CURRENT_PORT" == "analog-output-lineout" ]]; then
   pactl set-sink-port alsa_output.pci-0000_00_1f.3.analog-stereo analog-output-headphones
else
   pactl set-sink-port alsa_output.pci-0000_00_1f.3.analog-stereo analog-output-lineout
fi


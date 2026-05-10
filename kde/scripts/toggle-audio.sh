#!/usr/bin/env bash
CARD="alsa_card.pci-0000_10_00.4"
ANALOG="output:analog-stereo"
DIGITAL="output:iec958-stereo"

current=$(pactl list cards | awk "/Name: $CARD/{f=1} f && /Active Profile:/{print \$3; exit}")

if [ "$current" = "$ANALOG" ]; then
    pactl set-card-profile "$CARD" "$DIGITAL"
    notify-send "Audio Output" "Switched to: Digital Stereo Out" --icon=audio-card
else
    pactl set-card-profile "$CARD" "$ANALOG"
    notify-send "Audio Output" "Switched to: Analog Stereo Out" --icon=audio-card
fi

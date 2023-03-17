#!/usr/bin/env bash

hidden=$(bspc query -N -n .hidden -d focused | tail -n 1);
if [ -z "$hidden" ]; then
  bspc node focused -g hidden=on
else
  bspc node "$hidden" -g hidden=off
  bspc node -f "$hidden"
fi

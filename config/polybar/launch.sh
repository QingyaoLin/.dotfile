#!/usr/bin/env bash

# See: https://polybar.readthedocs.io/en/stable/user/ipc.html
# If enable-ipc = true
# Terminates the bar
# polybar-msg cmd quit
#
# Toggles between the hidden and visible state.
# polybar-msg cmd toggle
#
# Restarts the bar in-place
# polybar-msg cmd restart
#
# Hides the bar
# polybar-msg cmd hide
#
# Makes the bar visible again, if it was hidden
# polybar-msg cmd show


# Otherwise you can use the nuclear option:
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch mybar
echo "---" > /tmp/polybar.log
polybar mybar 2>&1 | tee -a /tmp/polybar.log & disown

# Launch bar1 and bar2
# echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
# polybar bar1 2>&1 | tee -a /tmp/polybar1.log & disown
# polybar bar2 2>&1 | tee -a /tmp/polybar2.log & disown

echo "Bars launched..."

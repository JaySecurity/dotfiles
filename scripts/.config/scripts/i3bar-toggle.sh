#!/bin/bash

# Define the IDs of the i3bar outputs
i3bar_0="DP-0"
i3bar_1="DP-1"
i3bar_2="DP-2"
i3bar_3="HDMI-0"

# Get the ID of the currently focused workspace
focused_workspace=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name')

# Check if the focused workspace is the i3bar workspace
if [[ $focused_workspace == "workspace_$i3bar_1" ]]; then
  exit 0
fi

# Get the name of the output that has the latest notification
notify_output=$(dunstctl history -format "b %{output}" |
                   grep -oP 'output=\K\S+' |
                   sort -r | uniq | head -n1)

# Check if there is a notification for an i3bar output
if [[ $notify_output =~ ^output=DP- || $notify_output =~ ^output=HDMI- ]]; then
  # Show the i3bar on the affected output
  i3-msg bar mode "bar__$notify_output" dock
else
  # Hide all i3bars except for DisplayPort-1
  i3-msg bar mode "bar__$i3bar_0" hide
  i3-msg bar mode "bar__$i3bar_2" hide
  i3-msg bar mode "bar__$i3bar_3" hide

  # Show the i3bar on DisplayPort-1
  i3-msg bar mode "bar__$i3bar_1" dock
fi

# Check if the currently focused window is a browser window
browser=$(xprop -id $(xdotool getactivewindow) WM_CLASS | grep -i "chrome\|firefox\|opera\|vivaldi\|brave" | wc -l)

# Check if there is a new browser tab open
if [[ $browser -ne 0 ]]; then
  # Get the output that contains the active window
  geometry=$(xdotool getwindowfocus getwindowgeometry)
  x=$(echo "$geometry" | grep "Geometry:" | sed 's/.*+\([0-9]\+\)+.*/\1/')
  y=$(echo "$geometry" | grep "Geometry:" | sed 's/.*+[^+]\++\([0-9]\+\).*/\1/')
  output=$(xrandr | grep -w connected | awk -v x=$x -v y=$y '
    {
      if ($3 == "primary") {
        if (x >= $4 && y >= $5) {
          print $1
        }
      } else {
        if (x >= $3 && y >= $4) {
          print $1
        }
      }
    }
  ')

  # Show the i3bar on the output of the new browser tab
  if [[ $output =~ ^DP- || $output == $i3bar_3 ]]; then
    i3-msg bar mode "bar__$output" dock
  else
    i3-msg bar mode "bar__$i3bar_0" hide
    i3-msg bar mode "bar__$i3bar_1" hide
    i3-msg bar mode "bar__$i3bar_2" hide
  fi

  # Switch to the workspace of the new browser tab
  new_tab

# Check for updates and show Icon in sys-tray when updates are available.
#! /usr/bin/bash


# 󰳏    󰆧 󰮯 


start=" "
icons=""

# Check Pacman... 
updates_available=$(checkupdates | wc -l)

if [ "$updates_available" -gt 0 ]; then
  icons+=" 󰮯" 
fi


# Check Yay... 
updates_available=$(yay -Qua | wc -l)

if [ "$updates_available" -gt 0 ]; then
  icons+=" " 
fi

if [[ -n "$icons" ]]; then
  echo "$start$icons "
else
  echo " "
fi


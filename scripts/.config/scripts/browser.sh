#!/bin/bash

while [ -z "$select" ]; do
  select=$(echo -e 'Brave\nDev-Brave\nFirefox\nQute\nChromium' | dmenu -i -p "Which browser would you like to open?" -fn 'DejaVuSansM Nerd Font Mono-14')
  [ -z "$select" ] && exit 0
done
case $select in
Brave)
  exec brave --new-window --profile-directory="Default"
  ;;
Dev-Brave)
  exec brave --new-window --profile-directory="Profile 1"
  ;;
Firefox)
  exec firefox
  ;;
Qute)
  exec qutebrowser
  ;;
Chromium)
  exec chromium
  ;;
*)
  exit 0
  ;;
esac

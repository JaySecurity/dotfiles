#!/bin/bash

while [ "$select" != "No" -a "$select" != "Yes" ]; do
	select=$(echo -e 'No\nYes' | dmenu -i -p "Do you really want to exit i3?")
	[ -z "$select" ] && exit 0
done
[ "$select" = "No" ] && exit 0
i3-msg exit


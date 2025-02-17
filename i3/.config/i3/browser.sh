#!/bin/bash

while [ -z "$select" ]; do
	select=$(echo -e 'Firefox\nQute\nChromium' | dmenu -i -p "Which browser would you like to open?")
	[ -z "$select" ] && exit 0
done
case $select in
	Firefox)
		exec firefox;;
	Qute)
		exec qutebrowser;;
	Chromium)
		exec chromium-browser;;
	*)
		exit 0;;
esac

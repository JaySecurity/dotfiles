#!/bin/bash


while [ -z "$select" ]; do
	select=$(echo -e 'Left\nCenter\nRight\nUpper\nSelection' | dmenu -i -p "Screenshot Monitor:")
	[ -z "$select" ] && exit 0
done

while [ -z "$format" ]; do
        format=$(echo -e 'jpg\npng\ngif\nbmp' | dmenu -i -p "Select File Format: ")
        [ -z "$format" ] && exit 0
done

case $select in 
	Left)
		exec scrot -a 0,1200,1920,1080 -F ~/Pictures/Screenshots/screenshot-%Y-%m-%d@%H:%M:%S.$format;;
	Center)
		exec scrot -a 1920,1200,1920,1080 -F ~/Pictures/Screenshots/screenshot-%Y-%m-%d@%H:%M:%S.$format;;
	Right)
		exec scrot -a 3840,1200,1920,1080 -F ~/Pictures/Screenshots/screenshot-%Y-%m-%d@%H:%M:%S.$format;;
	Upper)
		exec scrot -a 1920,0,1920,1200 -F ~/Pictures/Screenshots/screenshot-%Y-%m-%d@%H:%M:%S.$format;;
	Selection)
		exec scrot -s -f -d 1 -F ~/Pictures/Screenshots/screenshot-%Y-%m-%d@%H:%M:%S.$format;;
	*)
		exit 0 ;;
esac


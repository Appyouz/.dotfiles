#!/bin/bash

VOLONOFF="$(amixer -D pulse get Master | grep Left: | sed 's/[][]//g' | awk '{print $6}')"

VOLICON="蓼"
MUTEICON="遼"


if [ "$VOLONOFF" = "on" ]; then
	echo "$VOLICON"
else
	echo "$MUTEICON"
fi

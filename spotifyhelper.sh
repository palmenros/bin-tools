#!/bin/bash
fallback="%{F#66}  none%{F-}"
#fallback="  %{F#66}none%{F-}"

if [[ $(playerctl -l 2> /dev/null) == "" ]]; then
	echo $fallback
else
	artist=$(playerctl metadata artist 2> /dev/null)
	title=$(playerctl metadata title 2> /dev/null)
	output=$(echo $title - $artist)
	sstatus=$(playerctl status 2> /dev/null)

	if [[ $artist == "" || $title == "" || $sstatus == "" ]]; then
		echo $fallback
	else
		if [[ $sstatus == "Playing" ]]; then
			echo " $output"
		else
			echo " $output"
		fi
	fi
fi

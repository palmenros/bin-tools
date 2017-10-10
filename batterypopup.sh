#!/bin/bash

PIDS=$(pgrep i3)

for p in $PIDS; do
	dbus=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$p/environ | cut -d "=" -f 2,3 | tr -d '\000')
done

export DBUS_SESSION_BUS_ADDRESS=$dbus

BATTINFO=`/usr/bin/acpi -b`
if [[ `echo $BATTINFO | grep Discharging` && `echo $BATTINFO | /usr/bin/cut -f 2 -d ","` < "20%" ]] ; then
	message="Low battery: $(/usr/bin/acpi -b | /usr/bin/cut -d "," -f 2 | /usr/bin/tr -d " ") $(/usr/bin/acpi -b | /usr/bin/cut -d " " -f 5 | /usr/bin/cut -d ":" -f 1,2)"
	/usr/bin/notify-send -u critical "$message"
fi

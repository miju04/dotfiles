#!/bin/bash

# If an argument is passed (second run), execute the corresponding command
if [ -n "$1" ]; then
	case "$1" in
	"Shutdown")
		systemctl poweroff
		;;
	"Restart")
		systemctl reboot
		;;
	"Logout")
		hyprctl dispatch exit
		;;
	"Suspend")
		systemctl suspend
		;;
	"Hibernate")
		systemctl hibernate
		;;
	"Lock screen")
		hyprlock >/dev/null 2>&1 &
		;;
	esac
# If no arguments are passed (first run), print the options for Rofi
else
	printf "Shutdown\0icon\x1fsystem-shutdown\n"
	printf "Restart\0icon\x1fsystem-restart\n"
	printf "Logout\0icon\x1fxfsm-logout\n"
	printf "Suspend\0icon\x1fsystem-suspend\n"
	printf "Hibernate\0icon\x1fsystem-hibernate\n"
	printf "Lock screen\0icon\x1fsystem-lock-screen\n"
fi

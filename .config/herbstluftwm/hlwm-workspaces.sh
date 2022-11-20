#!/bin/sh

hash herbstclient xrandr

print_tags() {
	for tag in $(herbstclient tag_status "$1"); do
		name=${tag#?}
		state=${tag%$name}
		case "$state" in
		'#')
            # active
			printf '%%{F#ff0000} %s %%{F-}' "$name"
			;;
		'+')
            # scratchpad
			printf '%%{F#aa0000}%%{R} %s %%{R}%%{F-}' "$name"
			;;
		'!')
            # urgent
            printf '%%{F#7811a1} %s %%{F-}' "$name"
			;;
		'.')
            # empty
			printf '%%{F#333} %s %%{F-}' "$name"
			;;
		*)
            # ocupied
            printf '%%{F#f0f0f0} %s %%{F-}' "$name"
		esac
	done
	printf '\n'
}

geom_regex='[[:digit:]]\+x[[:digit:]]\++[[:digit:]]\++[[:digit:]]\+'
geom=$(xrandr --query | grep "^$MONITOR" | grep -o "$geom_regex")
monitor=$(herbstclient list_monitors | grep "$geom" | cut -d: -f1)

print_tags "$monitor"

IFS="$(printf '\t')" herbstclient --idle | while read -r hook args; do
	case "$hook" in
	tag*)
		print_tags "$monitor"
		;;
	esac
done

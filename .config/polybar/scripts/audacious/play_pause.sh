#!/usr/bin/env bash

if pgrep -x "audacious" >/dev/null; then
	audacious -t
elif pgrep -x "cmus" >/dev/null; then
	if [ "$(cmus-remote -Q | grep ^status | cut -d' ' -f2)" = "playing" ]; then
		cmus-remote --pause
	elif [ "$(cmus-remote -Q | grep ^status | cut -d' ' -f2)" = "paused" ]; then
		cmus-remote --play
	fi
fi
#!/bin/python3

import subprocess
import os
from datetime import datetime

now = datetime.now()
dt_string = now.strftime("%I:%M %p")

FILE = "/tmp/dunstlog.json"

# Because certain programs like to insert their own newlines and fuck up my format (im looking at you thunderbird)
# we need to crunch each input to ensure that each component is its own line in the log file
app = {
    "APP_NAME": os.environ['DUNST_APP_NAME'],
    "SUMMARY": os.environ['DUNST_SUMMARY'],
    "BODY": os.environ['DUNST_BODY'],
    "ICON_PATH": os.environ['DUNST_ICON_PATH'],
    "URGENCY": os.environ['DUNST_URGENCY'],
    "ID": os.environ['DUNST_ID'],
    "PROGRESS": os.environ['DUNST_PROGRESS'],
    "CATEGORY": os.environ['DUNST_CATEGORY'],
    "STACK_TAG": os.environ['DUNST_STACK_TAG'],
    "URLS": os.environ['DUNST_URLS'],
    "TIMEOUT": os.environ['DUNST_TIMEOUT'],
    "TIMESTAMP": dt_string
}
# "DUNST_TIMESTAMP": os.environ['DUNST_TIMESTAMP']

# filter stuff ans add custom icons if you want

# e.g.
# notify-send -u urgency "summary" "body" -i "icon"
#
# this will give
# app-name - notif-send
# urgency - upgency
# summary - summary
# body - body
# icon - icon

# Rules for notifs that send their icons over the wire (w/o an actual path)
discard_crunch_appname = [
    "Calendar",
    "Volume",
    "Brightness",
    "Microphone",
    "pasystray"
]
if app["APP_NAME"] == "Spotify":
    random_name = subprocess.run(
        ["mktemp", "--suffix", ".png"], capture_output=True).stdout
    artlink = subprocess.run(["playerctl", "metadata", "mpris:artUrl"])
    artlink = artlink.replace("open.spotify.com", "i.scdn.co")
    subprocess.run(["curl", "-s", artlink, "-o", random_name])
    crunch_icon = random_name
elif app["APP_NAME"] == "VLC media player":
    crunch_icon = "vlc"
elif app["APP_NAME"] in discard_crunch_appname:
    exit(0)

f = open(FILE, "a+")
f.write(str(app) + '\n')
f.close()

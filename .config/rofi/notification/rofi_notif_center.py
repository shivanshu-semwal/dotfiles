#!/bin/python

# https://dunst-project.org/documentation/
import ast
import subprocess
import re

CLEANR = re.compile('<.*?>')

def cleanhtml(raw_html):
    cleantext = re.sub(CLEANR, ' ', raw_html)
    return cleantext

FILE = "/tmp/dunstlog.json"
notifs = []

with open(FILE) as f:
    for notif in f:
        notifs.append(ast.literal_eval(notif))

items = []
WIDTH = 37 - 9  # 9 spaces for tme stamp

for notif in notifs[::-1]:
    title = "<b>" + notif['APP_NAME'][:WIDTH] + "</b>"
    time = notif['TIMESTAMP']
    body = cleanhtml(notif['BODY']).replace('\n', '')
    summary = notif['SUMMARY']
    icon = notif['ICON_PATH']
    space = " " * (WIDTH - min(len(notif['APP_NAME']), WIDTH))
    items.append(title + space + time + "\n" + summary + "\n" +
                 body + "\n" + "\x00icon\x1f" + icon)

THEME = "~/.config/rofi/notification/theme.rasi"
subprocess.run(["rofi",
                "-markup-rows",
                "-theme",
                THEME,
                "-dmenu",
                "-eh", "3",
                "-sep", "\x0f",
                "-p", "Notification Center",
                "-no-fixed-num-lines",
                "-lines", "8",
                "-i",
                "-no-config"],
               input=bytes(chr(0x0f).join(items), 'utf-8'))

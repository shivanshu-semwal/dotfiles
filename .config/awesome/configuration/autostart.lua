local awful = require("awful")

-- Autostart some programs
awful.spawn("lxqt-policykit-agent")
awful.spawn("xfce4-power-manager")
awful.spawn("nm-applet")
awful.spawn("picom -b")
-- awful.spawn("/home/antihero/Scripts/wallpaper.sh")
awful.spawn("copyq")
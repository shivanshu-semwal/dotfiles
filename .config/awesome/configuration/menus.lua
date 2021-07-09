local beautiful = require("beautiful")
local awful = require("awful")
require("awful.autofocus")

local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Load Debian menu entries
local debian = require("debian.menu")
local has_fdo, freedesktop = pcall(require, "freedesktop")

--[[
    Menu:
        Create a launcher widget and a main menu
]]
myawesomemenu = {
    {"hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    {"manual", terminal .. " -e man awesome"},
    {"edit config", editor_cmd .. " " .. awesome.conffile},
    {"restart", awesome.restart}, {"quit", function() awesome.quit() end}
}
local menu_awesome = {"awesome-wm", myawesomemenu, beautiful.awesome_icon}
local menu_terminal = {"Open terminal", terminal}
if has_fdo
then
    mymainmenu = freedesktop.menu.build({
        before = {menu_awesome},
        after = {menu_terminal}
    })
else
    mymainmenu = awful.menu({
        items = {
            menu_awesome,
            {"Debian", debian.menu.Debian_menu.Debian},
            menu_terminal
        }
    })
end

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
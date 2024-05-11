local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")

require("awful.hotkeys_popup.keys")
require("./custom/env")

-- Create a launcher widget and a main menu
awesomemenu = {
	{ "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
	{ "Config", editor_cmd .. awesome.conffile },
	{ "Restart", awesome.restart },
	{ "Quit", function() awesome.quit() end },
}

toolsmenu = {
	{ "Terminal", function () awful.spawn(terminal) end, },
	{ "System Resources", function () awful.spawn(terminal .. " -e btop") end, }
}

powermenu = {
	{ "Lock", function() awful.spawn("betterlockscreen -l dim") end },
	{ "Suspend", function() awful.spawn("systemctl suspend") end },
	{ "Restart", function() awful.spawn("systemctl reboot") end },
	{ "Power Off", function() awful.spawn("systemctl poweroff") end }
}

mainmenu = awful.menu({
	items = {
		{ "Awesome", awesomemenu },
		{ "Tools", toolsmenu },
		{ "Power", powermenu }
	}
})

return mainmenu

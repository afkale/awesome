local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")

require("awful.hotkeys_popup.keys")
require("./custom/env")

-- Create a launcher widget and a main menu
awesomemenu = {
	{ "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
	{ "Config",  editor_cmd .. awesome.conffile },
	{ "Restart", awesome.restart },
	{ "Quit",    function() awesome.quit() end },
}

toolsmenu = {
	{ "Terminal",         terminal },
	{ "Network config",   terminal .. " -e nmtui", },
	{ "System Resources", terminal .. " -e btop", }
}

powermenu = {
	{ "Lock",      "betterlockscreen -l dim" },
	{ "Suspend",   "betterlockscreen -s dim" },
	{ "Restart",   "systemctl reboot" },
	{ "Power Off", "systemctl poweroff" }
}

mainmenu = awful.menu({
	items = {
		{ "Tools",   toolsmenu },
		{ "Awesome", awesomemenu },
		{ "Power",   powermenu },
	}
})

return mainmenu

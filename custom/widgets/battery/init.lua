local wibox = require'wibox'
local awful = require'awful'
local gears = require'gears'
local beautiful = require'beautiful'
local naughty = require'naughty'


local widget = wibox.widget {
	{
		layout = wibox.layout.fixed.horizontal,
		spacing = 2,
		{
			id = "text",
			resize = false,
			widget = wibox.widget.textbox,
			text = "󰂑",
			font = "CaskaydiaCove Nerd Font Mono 12" 
		},
		{
			id = "charging",
			resize = false,
			widget = wibox.widget.textbox,
			text = "",
			visible = false,
			font = "CaskaydiaCove Nerd Font Mono 12" 
		},
	},
    widget  = wibox.container.place,
    shape = gears.shape.rounded_rect,
	valign = "center",
	fill_vertical = true
}

local tooltip = awful.tooltip {
    objects = { widget },
    mode = "outside",
    preferred_positions = { "bottom" },
}

local function get_battery_icon(battery)
	local icons = "󰂎󰁻󰁼󰁽󰁾󰁿󰂀󰂁󰂂󰁹"
	local icon = ((math.ceil(battery / 10) - 1) * 4) + 1
	-- 1 icon is 4 normal chars 
	return string.sub(icons, icon, icon + 3)
end

local function update_battery()
	awful.spawn.easy_async("acpi -b",
		function(stdout, stderr, reason, exit_code)
			local mainLine 
			for line in stdout:gmatch("[^\r\n]+") do
				if not line:match("unavailable") then
					mainLine = line
					break
				end
			end

			local percentage = tonumber(mainLine:match("(%d?%d?%d)%%"))
			local remaining = mainLine:match("%d?%d?%d%%, (.*)") or "Full"
			local isCharging = mainLine:match("Charging") == "Charging"

			local icon = get_battery_icon(percentage)
			local textbox = widget:get_children_by_id("text")[1]
			local charging = widget:get_children_by_id("charging")[1]

			tooltip:set_text(remaining)
			textbox:set_text(icon)
			charging:set_visible(isCharging)
		end
	)
end

local timer = gears.timer {
    timeout   = 5,
    autostart = true,
    callback  = function() update_battery(widget) end
}

return widget

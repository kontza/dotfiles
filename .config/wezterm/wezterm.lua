local wezterm = require("wezterm")
local act = wezterm.action
local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "Catppuccin Mocha"
config.default_prog = { "/opt/homebrew/bin/fish" }
-- config.font = wezterm.font("Hack FC Ligatured CCG", { weight = "Regular" })
config.font_size = 14
config.initial_cols = 140
config.initial_rows = 42
config.scrollback_lines = 12500
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true
config.window_background_opacity = 0.85
config.window_decorations = "RESIZE"
config.keys = {
	{ key = "ä", mods = "SHIFT|CTRL", action = act.RotatePanes("CounterClockwise") },
	{ key = "ä", mods = "CTRL", action = act.RotatePanes("Clockwise") },
	{ key = "t", mods = "CMD|SHIFT", action = act.ShowTabNavigator },
	{ key = "w", mods = "CMD", action = act.CloseCurrentTab({ confirm = true }) },
	{
		key = "c",
		mods = "ALT|SHIFT",
		action = wezterm.action_callback(function(window, pane)
			pane:inject_output("\x1b]104\x07")
		end),
	},
}

config.mouse_bindings = {
	-- Disable the default click behavior
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = wezterm.action.DisableDefaultAssignment,
	},
	-- Ctrl-click will open the link under the mouse cursor
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
	-- Disable the Ctrl-click down event to stop programs from seeing it when a URL is clicked
	{
		event = { Down = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = wezterm.action.Nop,
	},
}

return config

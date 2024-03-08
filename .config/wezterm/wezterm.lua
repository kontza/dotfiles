local wezterm = require("wezterm")
local act = wezterm.action
local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- The following colors are from https://github.com/mbadolato/iTerm2-Color-Schemes.git
-- Directory `dynamic-colors`
local env_to_colors = {
	["production"] = {
		-- # Red Sands
		"\x1b]4;0;#000000;1;#ff3f00;2;#00bb00;3;#e7b000;4;#0072ff;5;#bb00bb;6;#00bbbb;7;#bbbbbb;8;#555555;9;#bb0000;10;#00bb00;11;#e7b000;12;#0072ae;13;#ff55ff;14;#55ffff;15;#ffffff\x07",
		"\x1b]10;#d7c9a7;#7a251e;#ffffff\x07",
		"\x1b]17;#a4a390\x07",
		"\x1b]19;#000000\x07",
		"\x1b]5;0;#dfbd22\x07",
	},
	["qa"] = {
		-- # Royal
		"\x1b]4;0;#241f2b;1;#91284c;2;#23801c;3;#b49d27;4;#6580b0;5;#674d96;6;#8aaabe;7;#524966;8;#312d3d;9;#d5356c;10;#2cd946;11;#fde83b;12;#90baf9;13;#a479e3;14;#acd4eb;15;#9e8cbd\x07",
		"\x1b]10;#514968;#100815;#524966\x07",
		"\x1b]17;#1f1d2b\x07",
		"\x1b]19;#a593cd\x07",
		"\x1b]5;0;#c8bd1d\x07",
	},
	["edu"] = {
		-- # Ryuuko
		"\x1b]4;0;#2c3941;1;#865f5b;2;#66907d;3;#b1a990;4;#6a8e95;5;#b18a73;6;#88b2ac;7;#ececec;8;#5d7079;9;#865f5b;10;#66907d;11;#b1a990;12;#6a8e95;13;#b18a73;14;#88b2ac;15;#ececec\x07",
		"\x1b]10;#ececec;#2c3941;#ececec\x07",
		"\x1b]17;#002831\x07",
		"\x1b]19;#819090\x07",
		"\x1b]5;0;#819090\x07",
	},
	["test"] = {
		-- # Jackie Brown
		"\x1b]4;0;#2c1d16;1;#ef5734;2;#2baf2b;3;#bebf00;4;#246eb2;5;#d05ec1;6;#00acee;7;#bfbfbf;8;#666666;9;#e50000;10;#86a93e;11;#e5e500;12;#0000ff;13;#e500e5;14;#00e5e5;15;#e5e5e5\x07",
		"\x1b]10;#ffcc2f;#2c1d16;#23ff18\x07",
		"\x1b]17;#af8d21\x07",
		"\x1b]19;#ffffff\x07",
		"\x1b]5;0;#ffcc2f\x07",
	},
	["dev"] = {
		-- # Lavandula
		"\x1b]4;0;#230046;1;#7d1625;2;#337e6f;3;#7f6f49;4;#4f4a7f;5;#5a3f7f;6;#58777f;7;#736e7d;8;#372d46;9;#e05167;10;#52e0c4;11;#e0c386;12;#8e87e0;13;#a776e0;14;#9ad4e0;15;#8c91fa\x07",
		"\x1b]10;#736e7d;#050014;#8c91fa\x07",
		"\x1b]17;#37323c\x07",
		"\x1b]19;#8c91fa\x07",
		"\x1b]5;0;#8c91fa\x07",
	},
	["rhmgmt"] = {
		-- # BirdsOfParadise
		"\x1b]4;0;#573d26;1;#be2d26;2;#6ba18a;3;#e99d2a;4;#5a86ad;5;#ac80a6;6;#74a6ad;7;#e0dbb7;8;#9b6c4a;9;#e84627;10;#95d8ba;11;#d0d150;12;#b8d3ed;13;#d19ecb;14;#93cfd7;15;#fff9d5\x07",
		"\x1b]10;#e0dbb7;#2a1f1d;#573d26\x07",
		"\x1b]17;#563c27\x07",
		"\x1b]19;#e0dbbb\x07",
		"\x1b]5;0;#fff8d8\x07",
	},
	["mgmt"] = {
		-- # Espresso Libre
		"\x1b]4;0;#000000;1;#cc0000;2;#1a921c;3;#f0e53a;4;#0066ff;5;#c5656b;6;#06989a;7;#d3d7cf;8;#555753;9;#ef2929;10;#9aff87;11;#fffb5c;12;#43a8ed;13;#ff818a;14;#34e2e2;15;#eeeeec\x07",
		"\x1b]10;#b8a898;#2a211c;#ffffff\x07",
		"\x1b]17;#c3dcff\x07",
		"\x1b]19;#b8a898\x07",
		"\x1b]5;0;#d3c1af\x07",
	},
	["otsonkolo"] = {
		-- # Misterioso
		"\x1b]4;0;#000000;1;#ff4242;2;#74af68;3;#ffad29;4;#338f86;5;#9414e6;6;#23d7d7;7;#e1e1e0;8;#555555;9;#ff3242;10;#74cd68;11;#ffb929;12;#23d7d7;13;#ff37ff;14;#00ede1;15;#ffffff\x07",
		"\x1b]10;#e1e1e0;#2d3743;#000000\x07",
		"\x1b]17;#2d37ff\x07",
		"\x1b]19;#000000\x07",
		"\x1b]5;0;#000000\x07",
	},
	["kaivoskarhu"] = {
		-- # Mirage
		"\x1b]4;0;#011627;1;#ff9999;2;#85cc95;3;#ffd700;4;#7fb5ff;5;#ddb3ff;6;#21c7a8;7;#ffffff;8;#575656;9;#ff9999;10;#85cc95;11;#ffd700;12;#7fb5ff;13;#ddb3ff;14;#85cc95;15;#ffffff\x07",
		"\x1b]10;#a6b2c0;#1b2738;#ddb3ff\x07",
		"\x1b]17;#273951\x07",
		"\x1b]19;#d3dbe5\x07",
		"\x1b]5;0;#ffb38c\x07",
	},
	["siurvahti"] = {
		-- # midnight-in-mojave
		"\x1b]4;0;#1e1e1e;1;#ff453a;2;#32d74b;3;#ffd60a;4;#0a84ff;5;#bf5af2;6;#5ac8fa;7;#ffffff;8;#1e1e1e;9;#ff453a;10;#32d74b;11;#ffd60a;12;#0a84ff;13;#bf5af2;14;#5ac8fa;15;#ffffff\x07",
		"\x1b]10;#ffffff;#1e1e1e;#32d74b\x07",
		"\x1b]17;#4a504d\x07",
		"\x1b]19;#ffffff\x07",
		"\x1b]5;0;#ffffff\x07",
	},
}
local host_to_color = {
	[".*esmgmt.*"] = env_to_colors["rhmgmt"],
	[".*skmgmt.*"] = env_to_colors["mgmt"],
	["kaivoskarhu"] = env_to_colors["kaivoskarhu"],
	["otsonkolo"] = env_to_colors["otsonkolo"],
	["siurvahti"] = env_to_colors["siurvahti"],
	["vnkesa.*d"] = env_to_colors["dev"],
	["vnkesa.*e"] = env_to_colors["edu"],
	["vnkesa.*t"] = env_to_colors["test"],
	["vnkska.*d"] = env_to_colors["dev"],
	["vnkska.*t"] = env_to_colors["test"],
	["vnkske.*p"] = env_to_colors["production"],
	["vnkske.*q"] = env_to_colors["qa"],
	["vnkski.*p"] = env_to_colors["production"],
	["vnkski.*q"] = env_to_colors["qa"],
	["vnksky.*q"] = env_to_colors["qa"],
	["vnkskyleis0.e"] = env_to_colors["edu"],
	["vnkskyleis0.p"] = env_to_colors["production"],
}
local colored_panes = {}
wezterm.on("update-status", function(window, pane)
	local fg = pane:get_foreground_process_info() or {}
	if fg.name == "ssh" then
		local color_set = false
		for ndx = 2, #fg.argv do
			for k, v in pairs(host_to_color) do
				if string.find(fg.argv[ndx], k) then
					if not colored_panes[pane:pane_id()] then
						-- print(">>> NEW")
						for escape = 1, #v do
							pane:inject_output(v[escape])
						end
						colored_panes[pane:pane_id()] = fg.pid
						color_set = true
						print("Match found with " .. k .. ", argv " .. fg.argv[ndx])
						break
					end
				end
			end
			if color_set then
				break
			end
		end
	else
		if colored_panes[pane:pane_id()] then
			local ssh = wezterm.procinfo.get_info_for_pid(colored_panes[pane:pane_id()])
			if not ssh then
				-- print(">>> CLEARED")
				colored_panes[pane:pane_id()] = nil
				local default_scheme = {
					-- # catppuccin-mocha
					"\x1b]4;0;#45475a;1;#f38ba8;2;#a6e3a1;3;#f9e2af;4;#89b4fa;5;#f5c2e7;6;#94e2d5;7;#bac2de;8;#585b70;9;#f38ba8;10;#a6e3a1;11;#f9e2af;12;#89b4fa;13;#f5c2e7;14;#94e2d5;15;#a6adc8\x07",
					"\x1b]10;#cdd6f4;#1e1e2e;#f5e0dc\x07",
					"\x1b]17;#585b70\x07",
					"\x1b]19;#cdd6f4\x07",
					"\x1b]5;0;#cdd6f4\x07",
				}
				for escape = 1, #default_scheme do
					pane:inject_output(default_scheme[escape])
				end
			end
		end
	end
end)

config.color_scheme = "Catppuccin Mocha"
config.default_prog = { "/usr/local/bin/fish", "-l" }
config.font = wezterm.font("Hack FC Ligatured CCG", { weight = "Regular" })
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

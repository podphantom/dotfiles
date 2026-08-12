local wezterm = require("wezterm")
local utils = require("utils")
local keybinds = require("keybinds")
local scheme = wezterm.get_builtin_color_schemes()["nord"]
local gpus = wezterm.gui.enumerate_gpus()
require("on")

---------------------------------------------------------------
--- functions
---------------------------------------------------------------
-- selene: allow(unused_variable)
---@diagnostic disable-next-line: unused-function, unused-local
local function enable_wayland()
	local wayland = os.getenv("XDG_SESSION_TYPE")
	if wayland == "wayland" then
		return true
	end
	return false
end

---------------------------------------------------------------
--- Merge the Config
---------------------------------------------------------------
local function create_ssh_domain_from_ssh_config(ssh_domains)
	if ssh_domains == nil then
		ssh_domains = {}
	end
	for host, config in pairs(wezterm.enumerate_ssh_hosts()) do
		table.insert(ssh_domains, {
			name = host,
			remote_address = config.hostname .. ":" .. config.port,
			username = config.user,
			multiplexing = "None",
			assume_shell = "Posix",
		})
	end
	return { ssh_domains = ssh_domains }
end

--- load local_config
-- Write settings you don't want to make public, such as ssh_domains
package.path = os.getenv("HOME") .. "/.local/share/wezterm/?.lua;" .. package.path
local function load_local_config(module)
	local m = package.searchpath(module, package.path)
	if m == nil then
		return {}
	end
	return dofile(m)
end

local local_config = load_local_config("local")

---------------------------------------------------------------
--- Config
---------------------------------------------------------------
local config = {

	font = wezterm.font_with_fallback({
		{ family = "VictorMono Nerd Font", weight = "Medium" },
		{ family = "JetBrainsMono Nerd Font", weight = "Medium" },
	}),
	font_size = 11.5,

	check_for_updates = false,
	use_ime = true,
	send_composed_key_when_left_alt_is_pressed = false,
	send_composed_key_when_right_alt_is_pressed = false,
	ime_preedit_rendering = "Builtin",
	use_dead_keys = false,
	warn_about_missing_glyphs = false,
	-- enable_kitty_graphics = false,
	max_fps = 240,
	animation_fps = 1,
	cursor_blink_ease_in = "Constant",
	cursor_blink_ease_out = "Constant",
	cursor_blink_rate = 0,
	enable_wayland = true,
	color_scheme = "Dracula",
	window_background_opacity = 0.85,
	text_background_opacity = 1.0,
	window_decorations = "RESIZE",
	hide_tab_bar_if_only_one_tab = false,
	adjust_window_size_when_changing_font_size = false,
	selection_word_boundary = " \t\n{}[]()\"'`,;:│=&!%",
	window_padding = {
		left = 12,
		right = 12,
		top = 10,
		bottom = 10,
	},
	initial_cols = 100,
	initial_rows = 24,
	use_fancy_tab_bar = false,
	tab_max_width = 36,
	notification_handling = "SuppressFromFocusedTab",
	window_frame = {
		active_titlebar_bg = "#1e1f29",
		inactive_titlebar_bg = "#1e1f29",
	},
	colors = {
		foreground = "#f8f8f2",
		background = "#282a36",
		cursor_bg = "#bd93f9",
		cursor_border = "#bd93f9",
		cursor_fg = "#282a36",
		selection_bg = "#44475a",
		selection_fg = "#f8f8f2",
		ansi = {
			"#21222c", -- Black
			"#ff5555", -- Red
			"#50fa7b", -- Green
			"#f1fa8c", -- Yellow
			"#bd93f9", -- Blue / Purple
			"#ff79c6", -- Magenta
			"#8be9fd", -- Cyan
			"#f8f8f2", -- White
		},
		brights = {
			"#6272a4", -- Bright Black
			"#ff6e6e", -- Bright Red
			"#69ff94", -- Bright Green
			"#ffffa5", -- Bright Yellow
			"#d6acff", -- Bright Blue
			"#ff92df", -- Bright Magenta
			"#a4ffff", -- Bright Cyan
			"#ffffff", -- Bright White
		},
		tab_bar = {
			background = "#1e1f29",
			active_tab = { bg_color = "#44475a", fg_color = "#bd93f9", intensity = "Bold" },
			inactive_tab = { bg_color = "#21222c", fg_color = "#6272a4", intensity = "Normal" },
			inactive_tab_hover = { bg_color = "#44475a", fg_color = "#ff79c6", intensity = "Bold" },
			new_tab = { bg_color = "#21222c", fg_color = "#6272a4", intensity = "Normal" },
			new_tab_hover = { bg_color = "#44475a", fg_color = "#50fa7b", intensity = "Bold" },
		},
	},
	inactive_pane_hsb = {
		saturation = 0.8,
		brightness = 0.8,
	},
	exit_behavior = "CloseOnCleanExit",
	tab_bar_at_bottom = false,
	window_close_confirmation = "AlwaysPrompt",
	-- window_background_opacity = 0.8,
	disable_default_key_bindings = true,
	-- visual_bell = {
	-- 	fade_in_function = "EaseIn",
	-- 	fade_in_duration_ms = 150,
	-- 	fade_out_function = "EaseOut",
	-- 	fade_out_duration_ms = 150,
	-- },
	-- separate <Tab> <C-i>
	enable_csi_u_key_encoding = true,
	leader = { key = "Space", mods = "CTRL|SHIFT" },
	keys = keybinds.create_keybinds(),
	key_tables = keybinds.key_tables,
	mouse_bindings = keybinds.mouse_bindings,
	-- https://github.com/wez/wezterm/issues/2756
	webgpu_preferred_adapter = gpus[1],
	prefer_egl = true,
	front_end = "WebGpu",
}

config.hyperlink_rules = {
	-- Matches: a URL in parens: (URL)
	{
		regex = "\\((\\w+://\\S+)\\)",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in brackets: [URL]
	{
		regex = "\\[(\\w+://\\S+)\\]",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in curly braces: {URL}
	{
		regex = "\\{(\\w+://\\S+)\\}",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in angle brackets: <URL>
	{
		regex = "<(\\w+://\\S+)>",
		format = "$1",
		highlight = 1,
	},
	-- Then handle URLs not wrapped in brackets
	{
		-- Before
		--regex = '\\b\\w+://\\S+[)/a-zA-Z0-9-]+',
		--format = '$0',
		-- After
		regex = "[^(]\\b(\\w+://\\S+[)/a-zA-Z0-9-]+)",
		format = "$1",
		highlight = 1,
	},
	-- implicit mailto link
	{
		regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
		format = "mailto:$0",
	},
}
table.insert(config.hyperlink_rules, {
	regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
	format = "https://github.com/$1/$3",
})

local merged_config = utils.merge_tables(config, local_config)
return utils.merge_tables(merged_config, create_ssh_domain_from_ssh_config(merged_config.ssh_domains))

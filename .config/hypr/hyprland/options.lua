-- Refer to https://wiki.hyprland.org/Configuring/Variables/

local style = require("style")

-- Bezier curves
hl.curve("wind", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("winIn", { type = "bezier", points = { { 0.1, 1.1 }, { 0.1, 1.1 } } })
hl.curve("winOut", { type = "bezier", points = { { 0.3, -0.3 }, { 0.0, 1.0 } } })
hl.curve("liner", { type = "bezier", points = { { 1.0, 1.0 }, { 1.0, 1.0 } } })

-- Animations
hl.animation({ leaf = "windows", enabled = true, speed = 6, bezier = "wind", style = "slide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 6, bezier = "winIn", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "winOut", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "wind", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "liner" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 30, bezier = "liner", style = "loop" })
hl.animation({ leaf = "fade", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "wind" })

-- https://wiki.hyprland.org/Configuring/Variables/#general
hl.config({
	general = {
		["col.active_border"] = { colors = { style.background, style.color6 }, angle = 45 },
		["col.inactive_border"] = style.background,
		border_size = 2,
		gaps_in = 5,
		gaps_out = 5,
		layout = "dwindle",
		allow_tearing = false,
		resize_on_border = true,
	},
	-- https://wiki.hyprland.org/Configuring/Variables/#decoration
	decoration = {
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		rounding = 10,
		blur = {
			enabled = true,
			ignore_opacity = true,
			new_optimizations = true,
			passes = 3,
			size = 3,
			vibrancy = 0.1696,
		},
	},
	-- https://wiki.hyprland.org/Configuring/Layouts/Dwindle-Layout/
	dwindle = {
		preserve_split = true,
	},
	-- https://wiki.hyprland.org/Configuring/Variables/#input
	input = {
		follow_mouse = 1,
		kb_layout = "us",
		kb_options = "caps:swapescape",
		repeat_delay = 300,
		repeat_rate = 30,
		sensitivity = 0,
		touchpad = {
			natural_scroll = true,
		},
	},
	cursor = {
		hide_on_key_press = true,
	},
	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		force_default_wallpaper = 0,
		vrr = 0,
		enable_anr_dialog = false,
	},
})

-- https://wiki.hyprland.org/Configuring/Advanced-and-Cool/Devices/
hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})

-- =============================================================================
-- Window Rules — Hyprland 0.55+ (Lua format)
-- Use hyprctl clients to check current class/title
-- =============================================================================

-- Obsidian
hl.window_rule({
	name = "obsidian-opacity",
	match = { class = "^obsidian$" },
	opacity = "0.8 0.8 1.0",
})

-- Kitty terminal
hl.window_rule({
	name = "kitty-opacity",
	match = { class = "^kitty$" },
	opacity = "0.8 0.8 1.0",
})

-- Kvantum Manager
hl.window_rule({
	name = "kvantum-manager",
	match = { class = "^kvantummanager$" },
	float = true,
	opacity = "0.8 0.8 1.0",
})

-- Blueman Manager
hl.window_rule({
	name = "blueman-manager",
	match = { class = "^blueman-manager$" },
	float = true,
	opacity = "0.8 0.7 1.0",
})

-- Network Manager Applet
hl.window_rule({
	name = "nm-applet",
	match = { class = "^nm-applet$" },
	float = true,
	opacity = "0.8 0.7 1.0",
})

-- Network Manager Connection Editor
hl.window_rule({
	name = "nm-connection-editor",
	match = { class = "^nm-connection-editor$" },
	float = true,
	opacity = "0.8 0.7 1.0",
})

-- Spotify (by class)
hl.window_rule({
	name = "spotify-opacity-class",
	match = { class = "^Spotify$" },
	opacity = "0.7 0.7 1.0",
})

-- Spotify (by initial title, for cases where class isn't set at open)
hl.window_rule({
	name = "spotify-opacity-title",
	match = { initial_title = "^Spotify Free$" },
	opacity = "0.7 0.7 1.0",
})

-- KDE Polkit Authentication Agent
hl.window_rule({
	name = "kde-polkit-agent",
	match = { class = "^org\\.kde\\.polkit-kde-authentication-agent-1$" },
	float = true,
	opacity = "0.8 0.7 1.0",
})

-- GNOME Polkit Authentication Agent
hl.window_rule({
	name = "gnome-polkit-agent",
	match = { class = "^polkit-gnome-authentication-agent-1$" },
	opacity = "0.8 0.7 1.0",
})

-- GTK Portal
hl.window_rule({
	name = "gtk-portal",
	match = { class = "^org\\.freedesktop\\.impl\\.portal\\.desktop\\.gtk$" },
	opacity = "0.8 0.7 1.0",
})

-- Hyprland Portal
hl.window_rule({
	name = "hyprland-portal",
	match = { class = "^org\\.freedesktop\\.impl\\.portal\\.desktop\\.hyprland$" },
	opacity = "0.8 0.7 1.0",
})

-- Yazi file manager
hl.window_rule({
	name = "yazi-floating-setup",
	match = { class = "^Yazi$" },
	float = true,
	size = { "monitor_w * 0.9", "monitor_h * 0.9" },
	opacity = "0.8 0.2 1.0",
})

-- bluetui — Bluetooth TUI
hl.window_rule({
	name = "bluetui-floating-setup",
	match = { class = "^bluetui$" },
	float = true,
	size = { "monitor_w * 0.75", "monitor_h * 0.75" },
	opacity = "0.8 0.2 1.0",
	dim_around = true,
	stay_focused = true,
})

-- wiremix — Audio mixer
hl.window_rule({
	name = "wiremix-floating-setup",
	match = { class = "^wiremix$" },
	float = true,
	size = { "monitor_w * 0.9", "monitor_h * 0.5" },
	opacity = "0.8 0.2 1.0",
	dim_around = true,
	stay_focused = true,
})

-- nmtui — Network manager TUI
hl.window_rule({
	name = "nmtui-floating-setup",
	match = { class = "^nmtui$" },
	float = true,
	size = { "monitor_w * 0.5", "monitor_h * 0.5" },
	opacity = "0.8 0.2 1.0",
	dim_around = true,
	stay_focused = true,
})

-- nwg-look
hl.window_rule({
	name = "nwg-look-float",
	match = { class = "^nwg-look$" },
	float = true,
})

-- KDE Ark
hl.window_rule({
	name = "kde-ark-float",
	match = { class = "^org\\.kde\\.ark$" },
	float = true,
})

-- Pavucontrol
hl.window_rule({
	name = "pavucontrol-float",
	match = { class = "^pavucontrol$" },
	float = true,
})

-- Uinta Engine - OpenGL game engine window
-- Use immediate mode to reduce latency and prevent event queue backup
hl.window_rule({
	name = "uinta-engine-immediate",
	match = { title = "^Uinta Engine" },
	immediate = true,
})

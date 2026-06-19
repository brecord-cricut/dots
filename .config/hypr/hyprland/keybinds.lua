-- See https://wiki.hyprland.org/Configuring/Binds/

-- Applications
hl.bind("SUPER + T", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + B", hl.dsp.exec_cmd("$BROWSER"))
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + M", hl.dsp.exit())
hl.bind("SUPER + E", hl.dsp.exec_cmd("kitty --class Yazi yazi"))
hl.bind("SUPER + CTRL + F", hl.dsp.window.fullscreen())
hl.bind("SUPER + W", hl.dsp.window.float())
hl.bind("SUPER + A", hl.dsp.exec_cmd("tofi-drun"))
hl.bind("SUPER + J", hl.dsp.layout("swapsplit"))
hl.bind("SUPER + K", hl.dsp.layout("togglesplit"))

-- Move focus
hl.bind("SUPER + left", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "d" }))

-- Switch workspaces
hl.bind("SUPER + 1", hl.dsp.focus({ workspace = "1" }))
hl.bind("SUPER + 2", hl.dsp.focus({ workspace = "2" }))
hl.bind("SUPER + 3", hl.dsp.focus({ workspace = "3" }))
hl.bind("SUPER + 4", hl.dsp.focus({ workspace = "4" }))
hl.bind("SUPER + 5", hl.dsp.focus({ workspace = "5" }))
hl.bind("SUPER + 6", hl.dsp.focus({ workspace = "6" }))
hl.bind("SUPER + 7", hl.dsp.focus({ workspace = "7" }))
hl.bind("SUPER + 8", hl.dsp.focus({ workspace = "8" }))
hl.bind("SUPER + 9", hl.dsp.focus({ workspace = "9" }))
hl.bind("SUPER + 0", hl.dsp.focus({ workspace = "10" }))

-- Move window to workspace
hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = "1" }))
hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = "2" }))
hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = "3" }))
hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = "4" }))
hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = "5" }))
hl.bind("SUPER + SHIFT + 6", hl.dsp.window.move({ workspace = "6" }))
hl.bind("SUPER + SHIFT + 7", hl.dsp.window.move({ workspace = "7" }))
hl.bind("SUPER + SHIFT + 8", hl.dsp.window.move({ workspace = "8" }))
hl.bind("SUPER + SHIFT + 9", hl.dsp.window.move({ workspace = "9" }))
hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = "10" }))

-- Move window to workspace silently (don't follow)
hl.bind("SUPER + CTRL + 1", hl.dsp.window.move({ workspace = "1", follow = false }))
hl.bind("SUPER + CTRL + 2", hl.dsp.window.move({ workspace = "2", follow = false }))
hl.bind("SUPER + CTRL + 3", hl.dsp.window.move({ workspace = "3", follow = false }))
hl.bind("SUPER + CTRL + 4", hl.dsp.window.move({ workspace = "4", follow = false }))
hl.bind("SUPER + CTRL + 5", hl.dsp.window.move({ workspace = "5", follow = false }))
hl.bind("SUPER + CTRL + 6", hl.dsp.window.move({ workspace = "6", follow = false }))
hl.bind("SUPER + CTRL + 7", hl.dsp.window.move({ workspace = "7", follow = false }))
hl.bind("SUPER + CTRL + 8", hl.dsp.window.move({ workspace = "8", follow = false }))
hl.bind("SUPER + CTRL + 9", hl.dsp.window.move({ workspace = "9", follow = false }))
hl.bind("SUPER + CTRL + 0", hl.dsp.window.move({ workspace = "10", follow = false }))

-- Move/resize windows with mouse
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Resize windows
hl.bind("SUPER + SHIFT + right", hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + SHIFT + left", hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -30, relative = true }), { repeating = true })
hl.bind("SUPER + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 30, relative = true }), { repeating = true })

-- Screen locking
hl.bind("SUPER + CTRL + Q", hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER + Escape", hl.dsp.exec_cmd("sh -c 'pgrep wlogout || wlogout'"))

-- Volume and Media Control
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

-- Screen brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s +5%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 5%"))

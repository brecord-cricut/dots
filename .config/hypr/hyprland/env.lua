-- See https://wiki.hyprland.org/Configuring/Environment-variables/

hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", "24")

-- Nvidia
-- hl.env("LIBVA_DRIVER_NAME",          "nvidia")
-- hl.env("GBM_BACKEND",                "nvidia-drm")
-- hl.env("__GLX_VENDOR_LIBRARY_NAME",  "nvidia") -- remove if firefox crashes
-- hl.env("NVD_BACKEND",                "direct")
-- hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- Toolkit Backend Variables
hl.env("GDK_BACKEND", "wayland,*")
hl.env("SDL_VIDEODRIVER", "wayland,x11")

-- XDG Specifications
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

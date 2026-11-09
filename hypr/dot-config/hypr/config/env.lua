hl.env("GDK_SCALE", "2")
hl.env("XCURSOR_SIZE", "20")
hl.env("HYPRCURSOR_SIZE", "20")

hl.env("GDK_BACKEND", "wayland,x11,*")
-- Also set in ~/.config/uwsm/env: hl.env only applies to children of Hyprland,
-- makes GTK4 keep window backgrounds transparent so that Hyprland's blur applies
hl.env("GDK_WAYLAND_DISABLE", "ext_background_effect_manager_v1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("OZONE_PLATFORM", "wayland")
hl.env("XDG_SESSION_TYPE", "wayland")

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

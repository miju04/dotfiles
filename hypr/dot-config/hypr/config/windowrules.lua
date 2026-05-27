hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })

hl.window_rule({
	name = "no-gaps-wtv1",
	match = {
		float = false,
		workspace = "w[tv1]",
	},
	border_size = 0,
	rounding = 0,
})

hl.window_rule({
	name = "no-gaps-f1",
	match = {
		float = false,
		workspace = "f[1]",
	},
	border_size = 0,
	rounding = 0,
})

hl.window_rule({
	name = "suppress-maximize-events",
	match = {
		class = ".*",
	},
	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

hl.window_rule({
	name = "flout sound and bluetooth settings",
	match = {
		class = "org.pulseaudio.pavucontrol|blueberry.py",
	},

	float = true,
})

hl.window_rule({
	name = "float and center file pickers",
	match = {
		class = "xdg-desktop-portal-gtk",
		title = "^(Open.*Files?|Save.*Files?)",
	},

	float = true,
})

hl.window_rule({
	name = "float and center Okular text notes",
	match = {
		class = "org.kde.okular",
		title = "^(New Text Note — Okular)",
	},

	float = true,
})

hl.window_rule({
	name = "keepassxc-to-ws10",
	match = {
		class = "org.keepassxc.KeePassXC",
		title = ".*\\.kdbx \\[Locked] - KeePassXC",
	},

	workspace = "10 silent",
})

hl.window_rule({
	name = "keepassxc-popups-float",
	match = {
		class = "org.keepassxc.KeePassXC",
		title = "Generate Password",
	},

	float = true,
})

hl.window_rule({
	name = "floating-focus",
	match = {
		float = true,
	},

	stay_focused = true,
	no_follow_mouse = true,
	size = { "monitor_w*0.8", "monitor_h*0.8" },
	center = true,
})

hl.layer_rule({
	name = "blur-waybar",
	match = {
		namespace = "waybar",
	},

	blur = true,
})

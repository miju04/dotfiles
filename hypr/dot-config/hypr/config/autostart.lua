local apps = require("config.apps")

hl.on("hyprland.start", function()
	hl.exec_cmd(apps.browser)
	hl.exec_cmd("uwsm app -- keepassxc")

	hl.exec_cmd("systemctl --user start hyprpaper.service")
	hl.exec_cmd("systemctl --user start waybar.service")
	hl.exec_cmd("systemctl --user start swaync.service")
	hl.exec_cmd("systemctl --user start hypridle.service")
	hl.exec_cmd("systemctl --user start hyprpolkitagent.service")
end)

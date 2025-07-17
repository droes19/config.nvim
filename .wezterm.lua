local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.set_environment_variables = {}
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	-- Use OSC 7 as per the above example
	config.set_environment_variables["prompt"] = "$E]7;file://localhost/$P$E\\$E[32m$T$E[0m $E[35m$P$E[36m$_$G$E[0m "
	-- use a more ls-like output format for dir
	config.set_environment_variables["DIRCMD"] = "/d"
	-- And inject clink into the command prompt
	config.default_prog =
		{ "C:\\Windows\\System32\\cmd.exe", "/s", "/k", "C:\\Projects\\Program\\clink\\clink.bat", "inject" }
end

config.color_scheme = "tokyonight_night"
config.initial_cols = 150
config.initial_rows = 30

config.font_size = 8

return config

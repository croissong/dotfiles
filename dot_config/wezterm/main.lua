-- https://wezfurlong.org/wezterm/config/files.html

local wezterm = require("wezterm")

local keys, key_tables = require("keys")()
local mouse_bindings = require("mouse")

require("start")

launch_menu = {
  {
    label = "New tab",
    cwd = wezterm.home_dir,
  },
}

local config = wezterm.config_builder()
config:set_strict_mode(true)

config.automatically_reload_config = false
config.check_for_updates = false
config.term = "wezterm"
config.color_scheme = "Gruvbox dark, pale (base16)"
config.enable_tab_bar = false
config.enable_wayland = true
config.font = wezterm.font("Hack")
config.font_size = 13
config.front_end = "WebGpu"
config.keys = keys
config.key_tables = key_tables
config.launch_menu = launch_menu
config.mouse_bindings = mouse_bindings
config.hyperlink_rules = hyperlink_rules
config.debug_key_events = false
config.key_map_preference = "Physical"
config.default_prog = { "fish" }
config.default_workspace = "moi"
config.scrollback_lines = 10000

return config

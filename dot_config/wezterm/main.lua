-- https://wezfurlong.org/wezterm/config/files.html

local wezterm = require("wezterm")

local keys = require("keys")
local mouse_bindings = require("mouse")

---
-- Custom functions
---

-- https://wezfurlong.org/wezterm/config/lua/wezterm/on.html#custom-events

wezterm.on("copy-scrollback", function(window, pane)
  local scrollback = pane:get_lines_as_text(250)
  window:copy_to_clipboard(scrollback)
end)

wezterm.on("copy-cmd", function(window, pane)
  local scrollback = pane:get_lines_as_text()
  string_after_prompt = string.match(scrollback, ".*❯ (.*)")
  cmd = string_after_prompt:gsub("\n", "")
  window:copy_to_clipboard(cmd)
end)

search_mode = wezterm.gui.default_key_tables().search_mode
table.insert(search_mode, { key = "w", mods = "CTRL", action = wezterm.action({ CopyMode = "ClearPattern" }) })

key_tables = {
  search_mode = search_mode,
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
config.mouse_bindings = mouse_bindings
config.hyperlink_rules = hyperlink_rules
config.debug_key_events = false
config.key_map_preference = "Physical"
config.default_prog = { "fish" }

return config

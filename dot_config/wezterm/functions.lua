local wezterm = require("wezterm")

functions = {}

functions.copy_scrollback = function(window, pane)
  local scrollback = pane:get_lines_as_text(250)
  window:copy_to_clipboard(scrollback)
end

functions.copy_cmd = function(window, pane)
  local scrollback = pane:get_lines_as_text()
  string_after_prompt = string.match(scrollback, ".*❯ (.*)")
  cmd = string_after_prompt:gsub("\n", "")
  window:copy_to_clipboard(cmd)
end

return functions

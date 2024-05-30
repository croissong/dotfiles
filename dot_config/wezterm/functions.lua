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

-- https://wezfurlong.org/wezterm/config/lua/keyassignment/SwitchToWorkspace.html#prompting-for-the-workspace-name
functions.new_workspace = wezterm.action.PromptInputLine({
  description = wezterm.format({
    { Attribute = { Intensity = "Bold" } },
    { Foreground = { AnsiColor = "Fuchsia" } },
    { Text = "Enter name for new workspace" },
  }),
  action = wezterm.action_callback(function(window, pane, line)
    -- line will be `nil` if they hit escape without entering anything
    -- An empty string if they just hit enter
    -- Or the actual line of text they wrote
    if line then
      window:perform_action(
        wezterm.action.SwitchToWorkspace({
          name = line,
        }),
        pane
      )
    end
  end),
})

return functions

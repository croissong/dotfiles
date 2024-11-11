local wezterm = require("wezterm")
local io = require("io")
local os = require("os")

functions = {}

-- https://wezfurlong.org/wezterm/config/lua/wezterm/on.html#custom-events
functions.open_scrollback_in_editor = function(window, pane)
  -- Retrieve the text from the pane
  local text = pane:get_lines_as_text(pane:get_dimensions().scrollback_rows)

  -- Create a temporary file to pass to vim
  local name = os.tmpname()
  local f = io.open(name, "w+")
  f:write(text)
  f:flush()
  f:close()

  wezterm.background_child_process({
    "emacsclient",
    name,
  })

  -- Wait "enough" time for vim to read the file before we remove it.
  -- The window creation and process spawn are asynchronous wrt. running
  -- this script and are not awaitable, so we just pick a number.
  --
  -- Note: We don't strictly need to remove this file, but it is nice
  -- to avoid cluttering up the temporary directory.
  wezterm.sleep_ms(1000)
  os.remove(name)
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

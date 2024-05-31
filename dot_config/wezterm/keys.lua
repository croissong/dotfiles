local wezterm = require("wezterm")
local act = wezterm.action

local functions = require("functions")

function extend(t1, t2)
  return table.move(t2, 1, #t2, #t1 + 1, t1)
end

local menus = {
  {
    key = "q",
    mods = "CTRL",
    action = wezterm.action({ ShowLauncherArgs = { flags = "FUZZY|LAUNCH_MENU_ITEMS|WORKSPACES" } }),
  },
  {
    key = "q",
    mods = "ALT",
    action = wezterm.action({ ShowLauncherArgs = { flags = "FUZZY|KEY_ASSIGNMENTS|DOMAINS|COMMANDS" } }),
  },
  {
    key = "w",
    mods = "CTRL|ALT",
    action = functions.new_workspace,
  },
  {
    key = "`",
    mods = "ALT",
    action = "ShowTabNavigator",
  },
  {
    key = "p",
    mods = "CTRL",
    action = wezterm.action.ActivateCommandPalette,
  },
}

local panes = {
  {
    key = "2",
    mods = "CTRL",
    action = wezterm.action({
      SplitHorizontal = { domain = "CurrentPaneDomain" },
    }),
  },
  {
    key = "3",
    mods = "CTRL",
    action = wezterm.action({
      SplitVertical = { domain = "CurrentPaneDomain" },
    }),
  },
  {
    key = "q",
    mods = "CTRL|ALT",
    action = wezterm.action({
      CloseCurrentPane = { confirm = true },
    }),
  },
  {
    key = "RightArrow",
    mods = "CTRL|ALT",
    action = wezterm.action({ ActivatePaneDirection = "Right" }),
  },
  {
    key = "LeftArrow",
    mods = "CTRL|ALT",
    action = wezterm.action({ ActivatePaneDirection = "Left" }),
  },
  {
    key = "UpArrow",
    mods = "CTRL|ALT",
    action = wezterm.action({ ActivatePaneDirection = "Up" }),
  },
  {
    key = "DownArrow",
    mods = "CTRL|ALT",
    action = wezterm.action({ ActivatePaneDirection = "Down" }),
  },
}

local misc = {
  {
    key = "r",
    mods = "CTRL|ALT",
    action = "ReloadConfiguration",
  },
  {
    key = "+",
    mods = "CTRL",
    action = "IncreaseFontSize",
  },
  {
    -- key = "-" not working for some reason :(
    key = "raw:61",
    mods = "CTRL",
    action = "DecreaseFontSize",
  },
}

local keys = {
  {
    key = "Space",
    mods = "CTRL",
    action = "ActivateCopyMode",
  },
  {
    key = "x",
    mods = "CTRL",
    action = "QuickSelect",
  },
  {
    key = "c",
    mods = "CTRL|ALT",
    action = "Nop",
  },
  {
    key = "Enter",
    mods = "ALT",
    action = "DisableDefaultAssignment",
  },
  {
    key = "w",
    mods = "ALT",
    action = wezterm.action({ CopyTo = "Clipboard" }),
  },
  {
    key = "z",
    mods = "CTRL",
    action = wezterm.action({ PasteFrom = "Clipboard" }),
  },
  {
    key = "DownArrow",
    mods = "CTRL",
    action = wezterm.action({ ScrollByPage = 0.5 }),
  },
  {
    key = "UpArrow",
    mods = "CTRL",
    action = wezterm.action({ ScrollByPage = -0.5 }),
  },
  {
    key = "s",
    mods = "CTRL",
    action = wezterm.action({
      Search = { CaseInSensitiveString = "" },
    }),
  },
  {
    key = "e",
    mods = "CTRL|ALT",
    action = wezterm.action_callback(functions.copy_scrollback),
  },
  {
    key = "c",
    mods = "ALT",
    action = wezterm.action_callback(functions.copy_cmd),
  },
}

for i = 1, 8 do
  -- ALT + number to activate that tab
  table.insert(keys, {
    key = tostring(i),
    mods = "ALT",
    action = wezterm.action({ ActivateTab = i - 1 }),
  })
end

-- search mode

search_mode = wezterm.gui.default_key_tables().search_mode

search_mode_keys = {
  {
    key = "w",
    mods = "CTRL",
    action = act.CopyMode("ClearPattern"),
  },
}

extend(search_mode, search_mode_keys)

-- copy mode

copy_mode = wezterm.gui.default_key_tables().copy_mode

copy_mode_keys = {
  {
    key = "a",
    mods = "CTRL",
    action = act.CopyMode("MoveToStartOfLineContent"),
  },
  {
    key = "e",
    mods = "CTRL",
    action = act.CopyMode("MoveToEndOfLineContent"),
  },
  {
    key = "Space",
    mods = "CTRL",
    action = act.CopyMode({ SetSelectionMode = "Cell" }),
  },
}

extend(copy_mode, copy_mode_keys)

key_tables = {
  search_mode = search_mode,
  copy_mode = copy_mode,
}

extend(keys, menus)
extend(keys, panes)
extend(keys, misc)

return function()
  return keys, key_tables
end

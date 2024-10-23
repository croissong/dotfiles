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
    action = act.ShowLauncherArgs({ flags = "FUZZY|LAUNCH_MENU_ITEMS|WORKSPACES" }),
  },
  {
    key = "q",
    mods = "ALT",
    action = act.ShowLauncherArgs({ flags = "FUZZY|KEY_ASSIGNMENTS|DOMAINS|COMMANDS" }),
  },
  {
    key = "w",
    mods = "CTRL|ALT",
    action = functions.new_workspace,
  },
  {
    key = "`",
    mods = "ALT",
    action = act.ShowTabNavigator,
  },
  {
    key = "p",
    mods = "CTRL",
    action = act.ActivateCommandPalette,
  },
}

local panes = {
  {
    key = "2",
    mods = "CTRL",
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "3",
    mods = "CTRL",
    action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "q",
    mods = "CTRL|ALT",
    action = act.CloseCurrentPane({ confirm = true }),
  },
  {
    key = "RightArrow",
    mods = "CTRL|ALT",
    action = act.ActivatePaneDirection("Right"),
  },
  {
    key = "LeftArrow",
    mods = "CTRL|ALT",
    action = act.ActivatePaneDirection("Left"),
  },
  {
    key = "UpArrow",
    mods = "CTRL|ALT",
    action = act.ActivatePaneDirection("Up"),
  },
  {
    key = "DownArrow",
    mods = "CTRL|ALT",
    action = act.ActivatePaneDirection("Down"),
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

  {
    -- unbind because key combination already used for fish undo binding
    key = 'p',
    mods = 'CTRL',
    action = wezterm.action.DisableDefaultAssignment,
  },
}

local keys = {
  {
    key = "Space",
    mods = "CTRL",
    -- https://github.com/wez/wezterm/issues/4608
    action = wezterm.action_callback(function (window, pane)
        window:perform_action(act.ActivateCopyMode, pane)
        window:perform_action(act.CopyMode 'ClearPattern', pane)
    end),
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
    action = act.CopyTo("Clipboard"),
  },
  {
    key = "z",
    mods = "CTRL",
    action = act.PasteFrom("Clipboard"),
  },
  {
    key = "DownArrow",
    mods = "CTRL",
    action = act.ScrollByPage(0.5),
  },
  {
    key = "UpArrow",
    mods = "CTRL",
    action = act.ScrollByPage(-0.5),
  },
  {
    key = "s",
    mods = "CTRL",
    action = act.Search({ CaseInSensitiveString = "" }),
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
    action = act.ActivateTab(i - 1),
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
    key = "LeftArrow",
    mods = "CTRL",
    action = act.CopyMode("MoveBackwardWord"),
  },
  {
    key = "RightArrow",
    mods = "CTRL",
    action = act.CopyMode("MoveForwardWord"),
  },
  {
    key = "Space",
    action = act.CopyMode({ SetSelectionMode = "Cell" }),
  },
  {
    key = "Space",
    mods = "CTRL",
    action = act.CopyMode({ SetSelectionMode = "Block" }),
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

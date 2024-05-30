local wezterm = require("wezterm")

local keys = {
  {
    key = "x",
    mods = "CTRL",
    action = "ActivateCopyMode",
  },
  {
    key = " ",
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
    action = wezterm.action({ ScrollByPage = -0.5 }),
  },
  {
    key = "UpArrow",
    mods = "CTRL",
    action = wezterm.action({ ScrollByPage = 0.5 }),
  },
  {
    key = "r",
    mods = "CTRL|ALT",
    action = "ReloadConfiguration",
  },
  {
    key = "s",
    mods = "CTRL",
    action = wezterm.action({
      Search = { CaseInSensitiveString = "" },
    }),
  },
  {
    key = "q",
    mods = "CTRL",
    action = wezterm.action({ ShowLauncherArgs = { flags = "FUZZY|LAUNCH_MENU_ITEMS|KEY_ASSIGNMENTS|DOMAINS" } }),
  },
  {
    key = "w",
    mods = "CTRL|ALT",
    action = "ShowTabNavigator",
  },
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
    key = "e",
    mods = "CTRL|ALT",
    action = wezterm.action({ EmitEvent = "copy-scrollback" }),
  },
  {
    key = "c",
    mods = "ALT",
    action = wezterm.action({ EmitEvent = "copy-cmd" }),
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

return keys

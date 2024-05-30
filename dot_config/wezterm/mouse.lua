local wezterm = require("wezterm")

mouse_bindings = { -- Change the default click behavior so that it only selects
  -- text and doesn't open hyperlinks
  {
    event = {
      Up = {
        streak = 1,
        button = "Left",
      },
    },
    mods = "NONE",
    action = wezterm.action({ CompleteSelection = "PrimarySelection" }),
  },
  { -- and make CTRL-Click open hyperlinks
    event = {
      Up = {
        streak = 1,
        button = "Left",
      },
    },
    mods = "CTRL",
    action = "OpenLinkAtMouseCursor",
  }, -- Disable the 'Down' event of CTRL-Click to avoid weird program behaviors
  {
    event = {
      Down = {
        streak = 1,
        button = "Left",
      },
    },
    mods = "CTRL",
    action = "Nop",
  },
}

return mouse_bindings

-- https://wezfurlong.org/wezterm/config/files.html

local wezterm = require 'wezterm';

return {
   automatically_reload_config = false,
   check_for_updates = false,
   term = "wezterm",

   color_scheme = "Gruvbox Dark",
   enable_tab_bar = false,
   enable_wayland = false,
   font = wezterm.font("Hack"),
   font_size = 13,

   keys = {
    -- Turn off the default CMD-m Hide action on macOS by making it
      -- send the empty string instead of hiding the window
      -- toggle selection mode => x
      -- "They are not currently reassignable" https://wezfurlong.org/wezterm/copymode.html
      {key="x", mods="CTRL|ALT", action="ActivateCopyMode"},

      {key="c", mods="CTRL|ALT", action="Nop"},
      {key="Enter", mods="ALT", action="DisableDefaultAssignment"},

      {key="w", mods="ALT", action=wezterm.action{CopyTo="Clipboard"}},
      {key="y", mods="CTRL", action=wezterm.action{PasteFrom="Clipboard"}},

      {key="ü", mods="CTRL", action=wezterm.action{ScrollByLine=-20}},
      {key="ä", mods="CTRL", action=wezterm.action{ScrollByLine=20}},

      {key="r", mods="CTRL|ALT", action="ReloadConfiguration"},

      {key="s", mods="CTRL", action=wezterm.action{Search={CaseInSensitiveString=""}}},
  }
}

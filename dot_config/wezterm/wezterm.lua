-- https://wezfurlong.org/wezterm/config/files.html

local wezterm = require 'wezterm';

return {
   color_scheme = "Gruvbox Dark",
   enable_tab_bar = false,
   enable_wayland = true,
   font = wezterm.font("Hack"),
   font_size = 13,

   colors = {
      background = "red"
   }
}

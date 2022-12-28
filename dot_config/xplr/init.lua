version = "0.20.1"

local home = os.getenv("HOME")
local xpm_path = home .. "/.local/share/xplr/dtomvan/xpm.xplr"
local xpm_url = "https://github.com/dtomvan/xpm.xplr"

xplr.config.general.show_hidden = true
xplr.config.general.hide_remaps_in_help_menu = true

package.path = package.path .. ";" .. xpm_path .. "/?.lua;" .. xpm_path .. "/?/init.lua"

os.execute(string.format("[ -e '%s' ] || git clone '%s' '%s'", xpm_path, xpm_url, xpm_path))

require("xpm").setup({
  plugins = {
    -- Let xpm manage itself
    "dtomvan/xpm.xplr",
    { name = "sayanarijit/fzf.xplr" },
    { name = "sayanarijit/dual-pane.xplr" },
    { name = "igorepst/context-switch.xplr" },
    { name = "prncss-xyz/icons.xplr" },
  },
  auto_install = true,
  auto_cleanup = true,
})

require("context-switch").setup({
  key = "alt-s",
})

require("icons").setup()
require("fzf").setup()
require("dual-pane").setup()

xplr.config.modes.builtin.switch_layout.layout = nil

xplr.config.general.table.header.cols = {
  { format = "╭─── path", style = {} },
  { format = "permissions", style = {} },
  { format = "size", style = {} },
  { format = "modified", style = {} },
}

xplr.config.general.table.row.cols = {

  {
    format = "builtin.fmt_general_table_row_cols_1",
    style = {},
  },
  {
    format = "builtin.fmt_general_table_row_cols_2",
    style = {},
  },
  {
    format = "builtin.fmt_general_table_row_cols_3",
    style = {},
  },
  {
    format = "builtin.fmt_general_table_row_cols_4",
    style = {},
  },
}

xplr.config.general.table.col_widths = {
  { Percentage = 60 },
  { Percentage = 10 },
  { Percentage = 10 },
  { Percentage = 20 },
}

local wezterm = require("wezterm")
local mux = wezterm.mux

wezterm.on("gui-startup", function()
  create_workspace("1", "/")
  create_workspace("2", "/code/wrk")
end)

function create_workspace(name, dir)
  local project_dir = wezterm.home_dir .. dir
  local tab, build_pane, window = mux.spawn_window({
    workspace = name,
    cwd = project_dir,
  })
end

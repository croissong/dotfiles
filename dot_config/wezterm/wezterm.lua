-- https://wezfurlong.org/wezterm/config/files.html

local wezterm = require"wezterm"

---
-- Custom functions
---

-- https://wezfurlong.org/wezterm/config/lua/wezterm/on.html#custom-events

local os = require"os"
local io = require"io"

wezterm.on("copy-scrollback", function(window, pane)
	local scrollback = pane:get_lines_as_text(250)
	proc = io.popen("wl-copy -n", "w")
	proc:write(scrollback)
	proc:close()
end)

wezterm.on("copy-cmd", function(window, pane)
	local scrollback = pane:get_lines_as_text()
	string_after_prompt = string.match(scrollback, ".*❯ (.*)")
	cmd = string_after_prompt:gsub("\n", "")
	proc = io.popen("wl-copy -n", "w")
	proc:write(cmd)
	proc:close()
end)

---
-- Keybindings
---

local keys = { -- Turn off the default CMD-m Hide action on macOS by making it
-- send the empty string instead of hiding the window
-- toggle selection mode => x
-- "They are not currently reassignable" https://wezfurlong.org/wezterm/copymode.html
{
	key = "x",
	mods = "CTRL",
	action = "ActivateCopyMode",
}, {
	key = " ",
	mods = "CTRL",
	action = "QuickSelect",
}, {
	key = "c",
	mods = "CTRL|ALT",
	action = "Nop",
}, {
	key = "Enter",
	mods = "ALT",
	action = "DisableDefaultAssignment",
}, {
	key = "w",
	mods = "ALT",
	action = wezterm.action{ CopyTo = "Clipboard" },
}, {
	key = "z",
	mods = "CTRL",
	action = wezterm.action{ PasteFrom = "Clipboard" },
}, {
	key = "[",
	mods = "CTRL",
	action = wezterm.action{ ScrollByPage = -0.5 },
}, {
	key = "'",
	mods = "CTRL",
	action = wezterm.action{ ScrollByPage = 0.5 },
}, {
	key = "r",
	mods = "CTRL|ALT",
	action = "ReloadConfiguration",
}, {
	key = "s",
	mods = "CTRL",
	action = wezterm.action{
		Search = { CaseInSensitiveString = "" },
	},
}, {
	key = "q",
	mods = "CTRL",
	action = wezterm.action{ShowLauncherArgs={flags="FUZZY|LAUNCH_MENU_ITEMS|KEY_ASSIGNMENTS|DOMAINS"}},
}, {
	key = "w",
	mods = "CTRL|ALT",
	action = "ShowTabNavigator",
}, {
	key = "2",
	mods = "CTRL",
	action = wezterm.action{
		SplitHorizontal = { domain = "CurrentPaneDomain" },
	},
}, {
	key = "3",
	mods = "CTRL",
	action = wezterm.action{
		SplitVertical = { domain = "CurrentPaneDomain" },
	},
}, {
	key = "q",
	mods = "CTRL|ALT",
	action = wezterm.action{
		CloseCurrentPane = { confirm = true },
	},
}, {
	key = "\\",
	mods = "CTRL|ALT",
	action = wezterm.action{ ActivatePaneDirection = "Right" },
}, {
	key = ";",
	mods = "CTRL|ALT",
	action = wezterm.action{ ActivatePaneDirection = "Left" },
}, {
	key = "[",
	mods = "CTRL|ALT",
	action = wezterm.action{ ActivatePaneDirection = "Up" },
}, {
	key = "'",
	mods = "CTRL|ALT",
	action = wezterm.action{ ActivatePaneDirection = "Down" },
}, {
	key = "+",
	mods = "CTRL",
	action = "IncreaseFontSize",
}, {
	key = "e",
	mods = "CTRL|ALT",
	action = wezterm.action{ EmitEvent = "copy-scrollback" },
}, {
	key = "c",
	mods = "ALT",
	action = wezterm.action{ EmitEvent = "copy-cmd" },
} }

for i = 1, 8 do
	-- ALT + number to activate that tab
	table.insert(keys, {
		key = tostring(i),
		mods = "ALT",
		action = wezterm.action{ ActivateTab = i - 1 },
	})
end

---
-- Mouse bindings
---

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
	action = wezterm.action{ CompleteSelection = "PrimarySelection" },
}, { -- and make CTRL-Click open hyperlinks
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
} }

---
-- config
---

return {
	automatically_reload_config = false,
	check_for_updates = false,
	term = "wezterm",
	color_scheme = "Gruvbox Dark",
	enable_tab_bar = false,
	enable_wayland = true,
	font = wezterm.font("Hack"),
	font_size = 13,
	keys = keys,
	mouse_bindings = mouse_bindings,
  debug_key_events = false,
  key_map_preference = "Physical",
}

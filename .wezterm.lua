local wezterm = require 'wezterm'

local config = {}


if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.enable_tab_bar = false
config.use_fancy_tab_bar = false


-- local function get_appearance()
--   if wezterm.gui then
--     return wezterm.gui.get_appearance()
--   end
--   return 'Dark'
-- end
--
-- local function set_scheme(appearance)
--   if appearance:find 'Dark' then
--     return 'Seti'
--   else
--     return 'AtomOneLight'
--   end
-- end

config.color_scheme_dirs = { wezterm.home_dir .. "/.config/wezterm/themes" }

config.color_scheme = "HamBlue"

-- config.color_scheme = 'Catppuccin Mocha'
-- config.color_scheme = 'zenbones_dark'
config.font = wezterm.font 'JetBrains Mono'
-- config.font = wezterm.font 'CommitMono Nerd Font'

config.warn_about_missing_glyphs = false

config.window_padding = {
  left = '2cell',
  right = '2cell',
  top = '1cell',
  bottom = '1cell'
}

return config

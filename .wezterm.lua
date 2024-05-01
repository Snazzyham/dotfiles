local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.enable_tab_bar = false
config.use_fancy_tab_bar = false


-- config.color_scheme = 'Catppuccin Mocha'
config.color_scheme = 'zenbones_dark'
config.font = wezterm.font 'JetBrains Mono'
config.window_decorations = "RESIZE"
config.font_size = 16.0
-- config.font = wezterm.font 'CommitMono Nerd Font'

config.warn_about_missing_glyphs = false

config.window_padding = {
  left = '2cell',
  right = '2cell',
  top = '1cell',
  bottom = '1cell'
}

return config

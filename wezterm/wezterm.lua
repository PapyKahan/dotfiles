local wezterm = require 'wezterm'

return {
  default_prog = { 'nu' },
  font = wezterm.font('JetBrainsMono Nerd Font Mono', { weight = 'Medium' }),
  font_size = 10,
  color_scheme = "tokyonight",
  hide_tab_bar_if_only_one_tab = true,
}

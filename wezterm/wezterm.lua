local wezterm = require 'wezterm'

return {
  default_prog = { 'pwsh.exe', '-NoLogo' },
  font = wezterm.font('JetBrainsMono NF', { weight = 'Medium' }),
  font_size = 12,
  --color_scheme = "OneHalfDark",
  color_scheme = "Catppuccin Macchiato",
}

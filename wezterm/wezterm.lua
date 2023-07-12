local wt = require 'wezterm'
local config = {}
config.default_prog = { 'pwsh', '-NoLogo' }
--config.default_prog = { 'nu' }
config.font =
  wt.font('OverpassM Nerd Font')
return config

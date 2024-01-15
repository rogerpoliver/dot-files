---@type ChadrcConfig
local M = {}

M.ui = {
  theme = 'wombat',
  transparency = true,
  statusline = {
    theme = "vscode_colored",
  },
  extended_integrations = {
    "trouble"
  },
}

M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"

return M

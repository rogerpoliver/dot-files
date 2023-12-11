return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count
    -- local ayu_light = require("lualine.themes.ayu_light")

    -- stylua: ignore
    local colors = {
      blue     = '#76cce0',
      orange   = '#f39660',
      black    = '#080808',
      white    = '#FFFFFF',
      red      = '#fc5d7c',
      violet   = '#d183e8',
      grey     = '#2C2E35',
      green    = '#9ACB70',
    }

    local bubbles_theme = {
      normal = {
        a = { fg = colors.black, bg = colors.green },
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.black, bg = colors.green },
      },
      insert = {
        a = { fg = colors.black, bg = colors.red },
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.black, bg = colors.red },
      },
      visual = {
        a = { fg = colors.black, bg = colors.orange },
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.black, bg = colors.orange },
      },
      replace = {
        a = { fg = colors.black, bg = colors.blue },
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.black, bg = colors.blue },
      },
      inactive = {
        a = { fg = colors.white, bg = colors.black },
        b = { fg = colors.white, bg = colors.black },
        c = { fg = colors.black, bg = colors.black },
      },
    }

    lualine.setup({
      options = {
        theme = bubbles_theme,
        component_separators = '|',
        section_separators = { left = '  繁昌 ', right = ' 新築  ' },
      },
      sections = {
        lualine_a = {
          { 'mode', separator = { left = '', right = '' }, right_padding = 2 },
        },
        lualine_b = {'branch', 'diff', 'diagnostics', 'filename'},
        lualine_c = {},
        lualine_x = {},
        lualine_y = { 'filetype', 'progress' },
        lualine_z = {
          { 'location', separator = { left = '', right = '' }, left_padding = 2 },
        },
      },
      inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
      },
      tabline = {},
      extensions = {},

    })
  end,
}


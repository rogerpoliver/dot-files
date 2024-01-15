local M = {}

M.harpoon = {
  n = {
    ["<leader>ha"] = {
      function()
        local harpoon = require "harpoon"
        harpoon:list():append()
      end,
      "Harpoon Add",
    },
    ["<leader>hm"] = {
      function()
        local harpoon = require "harpoon"
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      "Harpoon Menu",
    },
    ["<leader>h1"] = {
      function()
        local harpoon = require "harpoon"
        harpoon:list():select(1)
      end,
      "Harpoon Menu",
    },
    ["<leader>h2"] = {
      function()
        local harpoon = require "harpoon"
        harpoon:list():select(2)
      end,
      "Harpoon Menu",
    },
    ["<leader>h3"] = {
      function()
        local harpoon = require "harpoon"
        harpoon:list():select(3)
      end,
      "Harpoon Menu",
    },
    ["<leader>h4"] = {
      function()
        local harpoon = require "harpoon"
        harpoon:list():select(4)
      end,
      "Harpoon Menu",
    },
    ["<leader>hls"] = {
      function()
        local harpoon = require "harpoon"
        harpoon.logger:show()
      end,
      "Harpoon Menu",
    },
  },
}

M.telescope = {
  n = {
    ["<leader>fh"] = {
      "<cmd>Telescope harpoon marks<cr>",
      "Find Harpoon",
    },
  },
}

return M

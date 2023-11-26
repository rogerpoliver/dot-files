local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Lazy will load every plugin
-- from rogerpoliver/plugins folder
require("lazy").setup({
  {import = "rogerpoliver.plugins"},
  {import = "rogerpoliver.plugins.editor"},
  {import = "rogerpoliver.plugins.lsp"},
})


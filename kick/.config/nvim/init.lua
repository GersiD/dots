-- Use lazy lua loader
vim.loader.enable()

-- Must include options config before anything loads
--NOTE: set all options before lazy
local ok, err = pcall(require, 'config.options')
if not ok then
  vim.notify('init.lua: Error loading options ' .. err, vim.log.levels.ERROR, { title = 'Config Error' })
end
-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  spec = {
    { import = 'plugins' },
    { import = 'plugins.lsp' },
    { import = 'plugins.ui' },
  },
  defaults = {
    version = false,
    lazy = true,
  },
})

-- Set Colorscheme
-- See `:help colorscheme`
local colorscheme = 'catppuccin'
vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol', { fg = '#FFFFFF' })
local ok, err = pcall(vim.cmd.colorscheme, colorscheme)
if not ok then
  vim.notify('init.lua: Error loading colorscheme ' .. err, vim.log.levels.ERROR, { title = 'Config Error' })
end
-- Load the highlight overrides
local ok, err = pcall(require, 'config.highlights')
if not ok then
  vim.notify('init.lua: Error loading highlights ' .. err, vim.log.levels.ERROR, { title = 'Config Error' })
end
-- Load the keymaps
local ok, err = pcall(require, 'config.keymaps')
if not ok then
  vim.notify('init.lua: Error loading keymaps ' .. err, vim.log.levels.ERROR, { title = 'Config Error' })
end
-- Load the autocommands
local ok, err = pcall(require, 'config.autocmds')
if not ok then
  vim.notify('init.lua: Error loading autocmds ' .. err, vim.log.levels.ERROR, { title = 'Config Error' })
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

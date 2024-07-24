-- Use lazy lua loader
vim.loader.enable()

-- Must include options config before anything loads
--NOTE: set all options before lazy
require('config.options')
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
    -- Detect tabstop and shiftwidth automatically
    { 'tpope/vim-sleuth', event = 'VeryLazy' },
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
vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol', { fg = '#FFFFFF' })
vim.schedule(function()
  vim.cmd.colorscheme('catppuccin')
end)
-- Load the keymaps
vim.schedule(function()
  require('config.keymaps')
end)
-- Load the autocommands
vim.schedule(function()
  require('config.autocmds')
end)

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

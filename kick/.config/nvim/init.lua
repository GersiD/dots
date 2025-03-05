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
vim.cmd.colorscheme('bamboo-vulgaris')
-- Load the keymaps
require('config.keymaps')
-- Load the autocommands
require('config.autocmds')

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

vim.keymap.set('n', '<leader>1', function()
  require('config.utils.terminals').run('zathura ' .. vim.fn.expand('%'))
end, { desc = 'Open PDF', buffer = true })
-- NOTE: Even if the opts to a vim.keymap call are incorrect or do not exist
-- The entire call will fail silently and the keymap will not be set
-- Ask me how I know...

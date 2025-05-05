vim.keymap.set('n', '<leader>1', function()
  vim.cmd("!zathura '%' &")
end, { desc = 'Open PDF', buffer = true })
vim.keymap.set('n', 'q', function()
  -- delete the current buffer
  vim.cmd('bdelete')
end, { desc = 'Close PDF', buffer = true })
-- NOTE: Even if the opts to a vim.keymap call are incorrect or do not exist
-- The entire call will fail silently and the keymap will not be set
-- Ask me how I know...

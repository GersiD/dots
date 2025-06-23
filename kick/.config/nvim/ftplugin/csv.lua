-- Open all CSV files with CSV Lens
vim.keymap.set('n', '<leader>1', function()
  -- require('config.utils.terminals').run('csvlens --color-columns ' .. vim.fn.expand('%')) -- Requires csvlens 12.0.2 or later
  require('config.utils.terminals').run('tw ' .. vim.fn.expand('%')) -- Requires csvlens 12.0.2 or later
end, { desc = 'Open CSV File', buffer = true })
vim.keymap.set('n', 'q', function()
  -- delete the current buffer
  vim.cmd('bdelete')
end, { desc = 'Close CSV', buffer = true })
vim.cmd('setlocal nowrap')
vim.cmd('TSBufDisable highlight')
vim.cmd('CsvViewEnable')

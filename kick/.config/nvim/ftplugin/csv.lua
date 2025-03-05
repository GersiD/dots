-- Open all CSV files with CSV Lens
vim.keymap.set('n', '<leader>1', function()
  require('config.utils.terminals').run('csvlens ' .. vim.fn.expand('%'))
end, { desc = 'Open CSV File', buffer = true })
vim.cmd('TSBufDisable highlight') -- TODO: Test to see if this should be BufDisable or Disable

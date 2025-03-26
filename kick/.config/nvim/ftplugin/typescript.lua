-- run current file in terminal
vim.keymap.set('n', '<leader>1', function()
  vim.cmd('terminal tsc ' .. vim.fn.expand('%') .. '; node ' .. vim.fn.expand('%:r') .. '.js')
end, { desc = 'Run TS File', buffer = true })

-- run current file in terminal
vim.keymap.set('n', '<leader>1', function()
  require('config.utils.terminals').run('tsc ' .. vim.fn.expand('%') .. '; node ' .. vim.fn.expand('%:r') .. '.js')
end, { desc = 'Run TS File', buffer = true })

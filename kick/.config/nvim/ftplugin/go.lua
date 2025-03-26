vim.keymap.set('n', '<leader>1', function()
  vim.cmd('terminal time go run .')
end, { desc = 'Run Go File', buffer = true })
vim.keymap.set('n', '<leader>2', function()
  require('config.utils.terminals').run('time go test')
end, { desc = 'Run Go Tests', buffer = true })

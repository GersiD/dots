vim.keymap.set('n', '<leader>1', function()
  require('config.utils.terminals').run('bash ' .. vim.fn.expand('%'), {})
end, { desc = 'Run Sh FIle' })

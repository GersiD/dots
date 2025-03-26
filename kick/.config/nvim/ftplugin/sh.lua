vim.keymap.set('n', '<leader>1', function()
  vim.cmd('terminal bash ' .. vim.fn.expand('%'))
end, { desc = 'Run Sh FIle' })

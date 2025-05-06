vim.keymap.set('n', 'q', function()
  vim.cmd('cclose')
end, { desc = 'Close qf', buffer = true })

vim.keymap.set('n', 'q', function()
  vim.cmd('close')
end, { desc = 'Close qf', buffer = true })

vim.keymap.set('n', '<leader>1', function()
  vim.cmd('!wc -l %')
end, { desc = 'Count number of lines in file', buffer = true })

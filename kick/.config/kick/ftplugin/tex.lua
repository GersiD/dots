vim.keymap.set('n', '<leader>1', function()
  vim.cmd('VimtexView')
end, { desc = 'Compile Latex File', buffer = true })
vim.opt.conceallevel = 0

vim.keymap.set('n', '<leader>ls', function()
  vim.cmd('LspStart ltex')
end, { desc = 'Start Ltex (spell check)', buffer = true })

vim.keymap.set('n', '<leader>1', function()
  vim.cmd('VimtexView')
end, { desc = 'Compile Latex File', buffer = true })
vim.opt.conceallevel = 0

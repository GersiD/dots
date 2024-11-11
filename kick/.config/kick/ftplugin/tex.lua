vim.keymap.set('n', '<leader>1', function()
  vim.cmd('VimtexView')
end, { desc = 'Compile Latex File', buffer = true })
vim.keymap.set('n', '<leader>lc', function()
  vim.cmd('VimtexClean')
  -- Delete the build folder if it exists
  vim.fn.delete(vim.fn.expand('%:p:h') .. '/build', 'rf')
end, { desc = 'Compile Latex File', buffer = true })
vim.keymap.set('n', '<leader>ls', function()
  vim.diagnostic.setqflist({
    namespace = vim.api.nvim_get_namespaces()['vim.lsp.ltex.3'],
    severity = vim.diagnostic.severity.HINT,
  })
end, { desc = 'Ltex Spelling QFix' })
vim.opt.conceallevel = 0

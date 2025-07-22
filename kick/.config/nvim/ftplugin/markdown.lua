vim.keymap.set('n', '<leader>ml', function()
  vim.cmd('Obsidian quick_switch')
end, { desc = 'Markdown Link', noremap = true, silent = true })

vim.keymap.set('n', '<leader>mc', function()
  vim.cmd('Obsidian check')
end, { desc = 'Markdown Check', noremap = true, silent = true })

vim.keymap.set('n', '<leader>mt', function()
  vim.cmd('Obsidian tags')
end, { desc = 'Markdown Tags', noremap = true, silent = true })

vim.keymap.set('n', '<leader>mf', function()
  vim.cmd('Obsidian search')
end, { desc = 'Find Obsidian', noremap = true, silent = true })

vim.keymap.set('n', '<leader>mo', function()
  vim.cmd('Obsidian open')
end, { desc = 'Open in Obsidian', noremap = true, silent = true })

vim.keymap.set('n', '<leader>mb', function()
  vim.cmd('Obsidian backlinks')
end, { desc = 'MD Backlinks', noremap = true, silent = true })

vim.keymap.set('n', '<leader>ls', function()
  vim.cmd('LspStart ltex_plus')
end, { desc = 'Start Ltex (spell check)', buffer = true })

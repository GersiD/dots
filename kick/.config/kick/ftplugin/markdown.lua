vim.keymap.set('n', 'gc', function()
  vim.cmd('ObsidianToggleCheckbox')
end, { desc = 'Add checkbox to line', noremap = true, silent = true })

vim.keymap.set('n', 'gC', function()
  vim.cmd('ObsidianToggleCheckbox')
  vim.cmd('ObsidianToggleCheckbox')
  vim.cmd('ObsidianToggleCheckbox')
  vim.cmd('ObsidianToggleCheckbox')
end, { desc = 'Complete checkbox item', noremap = true, silent = true })

vim.keymap.set('n', 'gt', function()
  vim.cmd('ObsidianTags')
end, { desc = 'Goto Obsidian Tags', noremap = true, silent = true })

vim.keymap.set('n', '<leader>ml', function()
  vim.cmd('ObsidianQuickSwitch')
end, { desc = 'Markdown Link', noremap = true, silent = true })

vim.keymap.set('n', '<leader>mc', function()
  vim.cmd('ObsidianCheck')
end, { desc = 'Markdown Check', noremap = true, silent = true })

vim.keymap.set('n', '<leader>mt', function()
  vim.cmd('ObsidianTags')
end, { desc = 'Markdown Tags', noremap = true, silent = true })

vim.keymap.set('n', '<leader>mo', function()
  vim.cmd('ObsidianOpen')
end, { desc = 'Open in Obsidian', noremap = true, silent = true })

vim.keymap.set('n', '<leader>mb', function()
  vim.cmd('ObsidianBacklinks')
end, { desc = 'MD Backlinks', noremap = true, silent = true })

vim.keymap.set('n', '<leader>ls', function()
  vim.cmd('LspStart ltex')
end, { desc = 'Start Ltex (spell check)', buffer = true })

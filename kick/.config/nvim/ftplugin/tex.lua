vim.keymap.set('n', '<leader>1', function()
  vim.cmd('VimtexView')
end, { desc = 'Compile Latex File', buffer = true })
vim.keymap.set('n', '<leader>lc', function()
  vim.cmd('VimtexClean')
  -- Delete the build folder if it exists
  vim.fn.delete(vim.fn.expand('%:p:h') .. '/build', 'rf')
end, { desc = 'Compile Latex File', buffer = true })
vim.keymap.set('n', '<leader>ls', function()
  vim.cmd('LspStart ltex_plus')
  ---@diagnostic disable-next-line: missing-fields
  require('trouble').toggle({
    mode = 'diagnostics',
    filter = function(items)
      return vim.tbl_filter(function(item)
        -- vim.notify(item['item.source'], vim.log.levels.INFO, {}) -- Wow that took a while
        return item['item.source'] == 'LTeX'
      end, items)
    end,
  })
end, { desc = 'Ltex Spelling QFix' })

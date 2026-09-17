vim.keymap.set('n', '<leader>1', function()
  vim.cmd('VimtexView')
end, { desc = 'View Latex File', buffer = true })

vim.keymap.set('n', '<leader>lc', function()
  vim.cmd('VimtexCompile') -- This starts continous compilation
end, { desc = 'Compile Latex File', buffer = true })

vim.keymap.set('n', '<leader>lC', function()
  vim.cmd('VimtexClean')
  -- Delete the build folder if it exists
  vim.fn.delete(vim.fn.expand('%:p:h') .. '/build', 'rf')
end, { desc = 'Clean Latex Compilation Folder', buffer = true })

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

-- Map 'tse' to the Toggle Star function
vim.keymap.set('n', 'tse', '<Plug>(vimtex-env-toggle-star)', { buffer = true, desc = "VimTeX: Toggle Star (Revert)" })

-- In LaTeX, we want section jumps, not matchit jumps

-- Jump to the bottom of the scope (Next)
vim.keymap.set("n", "]]", function()
  require("snacks").scope.jump({ bottom = true })
end, { buffer = true, desc = "Next Scope (Snacks)" })

-- Jump to the top of the scope (Previous)
vim.keymap.set("n", "[[", function()
  require("snacks").scope.jump({ bottom = false })
end, { buffer = true, desc = "Prev Scope (Snacks)" })

-- Enable soft wrapping and wrap at words instead of hard characters
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
-- Disable automatic line breaking
vim.opt_local.formatoptions:remove('t') -- Don't auto-wrap text when typing

-- Move by visual line instead of logical line (buffer-local maps)
vim.keymap.set('n', 'j', 'gj', { buffer = true, silent = true })
vim.keymap.set('n', 'k', 'gk', { buffer = true, silent = true })
vim.keymap.set('v', 'j', 'gj', { buffer = true, silent = true })
vim.keymap.set('v', 'k', 'gk', { buffer = true, silent = true })

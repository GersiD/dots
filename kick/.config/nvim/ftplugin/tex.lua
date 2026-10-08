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
  vim.cmd('lsp enable ltex_plus')
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
end, { desc = 'Ltex Spelling QFix', buffer = true })

-- Map 'tse' to the Toggle Star function
vim.keymap.set('n', 'tse', '<Plug>(vimtex-env-toggle-star)', { buffer = true, desc = "VimTeX: Toggle Star (Revert)" })

-- In LaTeX, we want section jumps, not matchit jumps
vim.keymap.set({ 'n', 'x', 'o' }, ']]', '<plug>(vimtex-]M)', { buffer = true, remap = true })
vim.keymap.set({ 'n', 'x', 'o' }, '[[', '<plug>(vimtex-[m)', { buffer = true, remap = true })

-- Enable soft wrapping and wrap at words instead of hard characters
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
-- Disable automatic line breaking
vim.opt_local.formatoptions:remove('t') -- Don't auto-wrap text when typing

-- Move by visual line, but by real line with a count so `5j` matches the relative numbers
vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { buffer = true, silent = true, expr = true })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { buffer = true, silent = true, expr = true })

-- texlab's symbols are the document outline: sections, labels, environments
vim.keymap.set('n', '<leader>fs', function()
  require('fzf-lua').lsp_document_symbols()
end, { desc = 'Find Sections/Labels', buffer = true })

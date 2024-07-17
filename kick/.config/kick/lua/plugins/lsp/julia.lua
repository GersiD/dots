vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*.jl',
  desc = 'Setup Julia',
  callback = function()
    vim.keymap.set('n', '<leader>1', function()
      require('config.utils.terminals').run('time julia' .. ' ' .. vim.fn.expand('%'))
    end, { desc = 'Run Julia File', buffer = true })
    -- require("null-ls").register({})
  end,
})

return {}

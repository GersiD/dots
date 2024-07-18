vim.keymap.set('n', '<leader>1', function()
  require('config.utils.terminals').run('time julia' .. ' ' .. vim.fn.expand('%'))
end, { desc = 'Run Julia File', buffer = true })

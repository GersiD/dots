vim.keymap.set('n', '<leader>1', function()
  require('config.utils.terminals').run('time julia' .. ' ' .. vim.fn.expand('%'))
end, { desc = 'Run Julia File', buffer = true })
vim.keymap.set('n', '<leader>2', function()
  require('config.utils.terminals').run('time julia runtests.jl')
end, { desc = 'Run Julia File', buffer = true })

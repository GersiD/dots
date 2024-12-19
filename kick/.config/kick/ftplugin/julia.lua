vim.keymap.set('n', '<leader>1', function()
  local num_cores = vim.fn.system('nproc')
  if num_cores >= '32' then
    require('config.utils.terminals').run('julia -t 32 --project=. ' .. vim.fn.expand('%'), {})
  else
    require('config.utils.terminals').run('julia -t 4 --project=. ' .. vim.fn.expand('%'), {})
  end
end, { desc = 'Run Julia File', buffer = true })
vim.keymap.set('n', '<leader>2', function()
  local num_cores = vim.fn.system('nproc')
  if num_cores >= '32' then
    require('config.utils.terminals').run('julia -t 32 --project=. ' .. './tests/runtest.jl', {})
  else
    require('config.utils.terminals').run('julia -t 4 --project=. ' .. './tests/runtest.jl', {})
  end
end, { desc = 'Run Julia Tests', buffer = true })
vim.keymap.set('n', '<leader>3', function()
  local num_cores = vim.fn.system('nproc')
  if num_cores >= '32' then
    require('config.utils.terminals').run('julia -t 32 --project=. -i ' .. vim.fn.expand('%'), {})
  else
    require('config.utils.terminals').run('julia -t 4 --project=. -i ' .. vim.fn.expand('%'), {})
  end
end, { desc = 'Run Julia REPL' })

vim.keymap.set('n', '<leader>1', function()
  local num_cores = vim.fn.system('nproc')
  if num_cores >= '32' then
    -- require('config.utils.terminals').run('time julia -t 32 --project=. ' .. vim.fn.expand('%'), {})
    local cmd = 'time julia -t 32 --project=. ' .. vim.fn.expand('%')
    vim.cmd('terminal ' .. cmd)
  else
    -- require('config.utils.terminals').run('time julia -t 4 --project=. ' .. vim.fn.expand('%'), {})
    local cmd = 'time julia --project=. ' .. vim.fn.expand('%')
    vim.cmd('terminal ' .. cmd)
  end
end, { desc = 'Run Julia File', buffer = true })
vim.keymap.set('n', '<leader>2', function()
  local num_cores = vim.fn.system('nproc')
  if num_cores >= '32' then
    -- require('config.utils.terminals').run('time julia -t 32 --project=./test ' .. './test/runtests.jl', {})
    local cmd = 'time julia -t 32 --project=./test ./test/runtests.jl'
    vim.cmd('terminal ' .. cmd)
  else
    -- require('config.utils.terminals').run('time julia -t 4 --project=./test ' .. './test/runtests.jl', {})
    local cmd = 'time julia --project=./test ./test/runtests.jl'
    vim.cmd('terminal ' .. cmd)
  end
end, { desc = 'Run Julia Tests', buffer = true })
vim.keymap.set('n', '<leader>3', function()
  local num_cores = vim.fn.system('nproc')
  local opts = { direction = 'vertical' }
  if num_cores >= '32' then
    -- require('config.utils.terminals').run('julia -t 32 --project=. -i ' .. vim.fn.expand('%'), opts)
    local cmd = 'julia -t 32 --project=. -i ' .. vim.fn.expand('%')
    vim.cmd('terminal ' .. cmd)
  else
    -- require('config.utils.terminals').run('julia -t 4 --project=. -i ' .. vim.fn.expand('%'), opts)
    local cmd = 'julia --project=. -i ' .. vim.fn.expand('%')
    vim.cmd('terminal ' .. cmd)
  end
end, { desc = 'Run Julia REPL' })

local terminals = require('config.utils.terminals')

local julia_cmd = 'julia -t auto --project=.'

---@param text string | string[]
local function send(text)
  terminals.repl_send('julia', julia_cmd, text, { direction = 'vertical' })
end

local function send_selection()
  -- grab the selection before leaving visual mode, so it survives the <Esc>
  local lines = vim.fn.getregion(vim.fn.getpos('v'), vim.fn.getpos('.'), { type = vim.fn.mode() })
  vim.api.nvim_feedkeys(vim.keycode('<Esc>'), 'nx', false)
  send(lines)
end

-- one REPL for the whole nvim session, so startup is only paid once
vim.keymap.set('n', '<leader>1', function()
  vim.cmd('write')
  local file = vim.fn.expand('%:p'):gsub('\\', '\\\\'):gsub('[$"]', '\\%0')
  send('@time include("' .. file .. '")')
end, { desc = 'Include Julia File in REPL', buffer = true })
vim.keymap.set('x', '<leader>1', send_selection, { desc = 'Send Selection to Julia REPL', buffer = true })
vim.keymap.set('n', '<leader>!', function()
  terminals.repl_restart('julia')
end, { desc = 'Restart Julia REPL', buffer = true })
vim.keymap.set('n', '<leader>2', function()
  local num_cores = vim.fn.system('nproc')
  if num_cores >= '32' then
    -- require('config.utils.terminals').run('time julia -t 32 --project=./test ' .. './test/runtests.jl', {})
    local cmd = 'time julia -t 32 --project=. -e "using Pkg; Pkg.test()"'
    vim.cmd('terminal ' .. cmd)
  else
    -- require('config.utils.terminals').run('time julia -t 4 --project=./test ' .. './test/runtests.jl', {})
    local cmd = 'time julia --project=. -e "using Pkg; Pkg.test()"'
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
end, { desc = 'Run Julia REPL', buffer = true })
vim.keymap.set('n', '<C-CR>', function()
  send(vim.api.nvim_get_current_line())
end, { desc = 'Send Line to Julia REPL', buffer = true })
vim.keymap.set('x', '<C-CR>', send_selection, { desc = 'Send Selection to Julia REPL', buffer = true })

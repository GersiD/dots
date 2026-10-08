local terminals = require('config.utils.terminals')

-- Revise is loaded first so edits to functions in the project are picked up without re-including
local julia_cmd = 'julia -t auto --project=. -i -e "using Revise"'
local repl_opts = { direction = 'vertical', bracketed_paste = true }

---@param text string | string[]
local function send(text)
  terminals.repl_send('julia', julia_cmd, text, repl_opts)
end

local function send_selection()
  -- grab the selection before leaving visual mode, so it survives the <Esc>
  local lines = vim.fn.getregion(vim.fn.getpos('v'), vim.fn.getpos('.'), { type = vim.fn.mode() })
  vim.api.nvim_feedkeys(vim.keycode('<Esc>'), 'nx', false)
  send(lines)
end

-- Send the whole top-level statement under the cursor (function, loop, struct, ...), then move to
-- the next one so repeated presses step through a script
local function send_block()
  vim.treesitter.get_parser():parse()
  local node = vim.treesitter.get_node()
  local root = node and node:tree():root()
  if not node or node:id() == root:id() then -- blank line between statements
    vim.cmd('normal! j')
    return
  end
  while node:parent():id() ~= root:id() do
    node = node:parent() --[[@as TSNode]]
  end

  local start_row, _, end_row, end_col = node:range()
  if end_col == 0 then -- range ends at the start of the following line
    end_row = end_row - 1
  end
  send(vim.api.nvim_buf_get_lines(0, start_row, end_row + 1, false))

  local next_line = vim.fn.nextnonblank(end_row + 2)
  if next_line > 0 then
    vim.api.nvim_win_set_cursor(0, { next_line, 0 })
  end
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
  terminals.run('time julia -t auto --project=. -e "using Pkg; Pkg.test()"', { direction = 'vertical' })
end, { desc = 'Run Julia Tests', buffer = true })
vim.keymap.set('n', '<leader>3', function()
  terminals.repl_toggle('julia', julia_cmd, repl_opts)
end, { desc = 'Toggle Julia REPL', buffer = true })
vim.keymap.set('n', '<C-CR>', send_block, { desc = 'Send Block to Julia REPL', buffer = true })
vim.keymap.set('x', '<C-CR>', send_selection, { desc = 'Send Selection to Julia REPL', buffer = true })

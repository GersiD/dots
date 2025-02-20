local M = {}
local Terminal = require('toggleterm.terminal').Terminal

---@class TerminalConfig
M.terminals = {
  lazygit = Terminal:new({ cmd = 'lazygit', direction = 'float' }),
  bottom = Terminal:new({ cmd = 'btop', direction = 'float' }),
  gdu = Terminal:new({ cmd = 'gdu', direction = 'float' }),
  float_term = Terminal:new({ cmd = 'fish' }),
  python = Terminal:new({ cmd = 'bpython' }),
}

if jit.os == 'Windows' then
  M.terminals.float_term = Terminal:new({ cmd = 'pwsh' })
  M.terminals.python = Terminal:new({ cmd = 'python' })
end

---@type string | nil
M.last_command = nil
---@type Terminal | nil
M.last_run_terminal = nil

function M.lazygit()
  M.terminals.lazygit:toggle()
end

function M.bottom()
  M.terminals.bottom:toggle()
end

function M.gdu()
  M.terminals.gdu:toggle()
end

function M.float()
  M.terminals.float_term:toggle()
end

function M.python()
  M.terminals.python:toggle()
end

function M.close_all()
  for _, term in pairs(M.terminals) do
    term:close()
  end
  M.last_run_terminal:close()
end

---@param command string | nil
function M.run(command, opts)
  local run_command = command or M.last_command
  if run_command == nil or run_command == '' then
    return
  end
  if M.last_run_terminal then -- close last terminal before starting a new one
    M.last_run_terminal:close()
  end
  M.last_command = run_command
  M.last_run_terminal = Terminal:new({
    cmd = run_command,
    hidden = true,
    direction = opts and opts.direction or 'float',
    close_on_exit = false,
    on_exit = function()
      -- enter normal mode
      vim.cmd('stopinsert')
    end,
    ---@diagnostic disable-next-line: unused-local
    on_open = function(term)
      if opts and opts.normal_on_open then
        -- enter normal mode
        vim.cmd('stopinsert')
      end
    end,
    float_opts = {
      border = 'curved',
    },
  }):toggle()
end

return M

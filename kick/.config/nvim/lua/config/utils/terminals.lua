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

---Long lived REPLs, keyed by name so they survive buffer switches.
---@type table<string, Terminal>
M.repls = {}

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
  for _, term in pairs(M.repls) do
    term:close()
  end
  if M.last_run_terminal then
    M.last_run_terminal:close()
  end
end

---Get a long lived REPL, starting it only if it is not already running.
---@param name string key the REPL is remembered under
---@param command string command used to start the REPL
---@param opts table | nil { direction }
---@return Terminal
function M.repl(name, command, opts)
  local term = M.repls[name]
  if term == nil then
    term = Terminal:new({
      cmd = command,
      hidden = true,
      direction = opts and opts.direction or 'vertical',
      close_on_exit = false,
      on_exit = function()
        M.repls[name] = nil -- forget it so the next call starts a fresh one
        vim.cmd('stopinsert')
      end,
      float_opts = {
        border = 'curved',
      },
    })
    M.repls[name] = term
  end
  if not term:is_open() then
    term:open()
  end
  return term
end

---Send a line to a long lived REPL, starting it if needed, and stay in the current window.
---@param name string key the REPL is remembered under
---@param command string command used to start the REPL
---@param text string | string[] line, or lines, to send
---@param opts table | nil { direction }
function M.repl_send(name, command, text, opts)
  M.repl(name, command, opts):send(text, true)
end

---Kill a long lived REPL so the next call starts it from scratch.
---@param name string key the REPL is remembered under
function M.repl_restart(name)
  local term = M.repls[name]
  if term then
    term:shutdown()
    M.repls[name] = nil
  end
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

vim.keymap.set('n', '<leader>1', function()
  -- Save the current buffer
  vim.cmd('w')
  -- Read the compile_commands.json file in the current directory
  local ok, compile_commands = pcall(function()
    return vim.fn.json_decode(vim.fn.readfile('compile_commands.json'))
  end)
  local command = ok and compile_commands and compile_commands[1]['run_command_custom'] or 'make'
  vim.notify('Running: ' .. command)
  require('config.utils.terminals').run(command, { direction = 'horizontal' })
end, { desc = 'Computer Graphics', buffer = true })
vim.keymap.set('n', '<leader>lh', '<CMD>ClangdSwitchSourceHeader<CR>', { desc = 'Switch Source/Header (C/C++)', buffer = true })

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set('n', '<C-v>', '"+p', { desc = 'Paste from system clipboard' })
vim.keymap.set('i', '<C-v>', function()
  vim.cmd('stopinsert')
  vim.cmd('normal! "+p')
end, { desc = 'Paste from system clipboard' })
vim.keymap.set('n', '<C-d>', function() end, { desc = 'disable default <C-d>' })
vim.keymap.set('v', '<C-c>', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set('x', '/', '<Esc>/\\%V') --search within visual selection - this is magic
vim.keymap.set('n', '<A-j>', '15j', {})
vim.keymap.set('n', '<A-k>', '15k', {})
vim.keymap.set('v', '<A-j>', '15j', {})
vim.keymap.set('v', '<A-k>', '15k', {})
vim.keymap.set('v', 'q', '<esc>', {})
-- vim.keymap.set("n", "<cr>", "ciw", { remap = true, desc = "Change word" })
vim.keymap.set('n', '<esc>', '<cmd>noh<cr><esc>', { desc = 'Escape and Clear hlsearch' })
vim.keymap.set('n', '<TAB>', '<cmd>BufferLineCycleNext<cr>', { desc = 'Prev buffer' })
vim.keymap.set('n', '<S-TAB>', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>', { desc = 'Neotree' })
vim.keymap.set('n', 'U', '<cmd>redo<cr>', { desc = 'Redo' })
vim.keymap.set('n', '<leader>gg', function()
  require('config.utils.terminals').lazygit()
end, { desc = 'LazyGit' })
vim.keymap.set('n', '<leader>tb', function()
  require('config.utils.terminals').bottom()
end, { desc = 'Float Btm' })
vim.keymap.set('n', '<leader>td', function()
  require('config.utils.terminals').gdu()
end, { desc = 'Float Disk Usage' })
vim.keymap.set('n', '<leader>tf', function()
  require('config.utils.terminals').float()
end, { desc = 'Float' })
vim.keymap.set('n', '<leader>tp', function()
  require('config.utils.terminals').python()
end, { desc = 'Python' })
vim.keymap.set('n', '<leader>tt', function()
  require('config.utils.terminals').run('cd ~ && nvim ~/vaults/gersi_notes/todo.md && cd -', {})
end, { desc = 'Terminal TODO' })
vim.keymap.set('n', '<leader>tc', function()
  vim.cmd('terminal askdeep')
end, { desc = 'Terminal ChatGPT' })

vim.keymap.set('n', '<leader>ss', function()
  require('snacks').picker.projects({
    patterns = { '.git', 'Project.toml' },
  })
end, { desc = 'Session' })
vim.keymap.set('n', '<C-0>', '$', { desc = 'End of line', remap = true }) -- TODO: Tmux blocks this :(
vim.api.nvim_set_keymap('v', '<leader>/', 'gc', { desc = 'Comment Selection' })
vim.api.nvim_set_keymap('n', '<leader>/', 'Vgc', { desc = 'Comment Line' })
vim.keymap.set('n', 'q', '<C-w>q', { desc = 'Quit', remap = true })
vim.api.nvim_set_keymap('t', '<C-s>', '<C-\\><C-n>', { desc = 'Quit' })
vim.keymap.set('t', '<C-q>', function()
  require('config.utils.terminals').close_all()
end, { desc = 'Close Open Terminals' })

-- Package manager keymaps
vim.keymap.set('n', '<leader>ps', '<cmd>Lazy<cr>', { desc = 'Package Status' })
vim.keymap.set('n', '<leader>pS', '<cmd>Lazy sync<cr>', { desc = 'Package Sync' })

-- Toggles
vim.keymap.set('n', '<leader>uf', '<CMD>KickstartFormatToggle<CR>', { desc = 'Format Toggle' })
vim.keymap.set('n', '<leader>uw', function()
  vim.opt.wrap = not vim.opt.wrap:get()
  if vim.opt.wrap:get() then
    vim.notify('Word wrap enabled', vim.log.levels.INFO, {})
  else
    vim.notify('Word wrap disabled', vim.log.levels.INFO, {})
  end
end, { desc = 'Toggle word wrap' })
vim.keymap.set('n', '<leader>ud', '<CMD>KickstartDiagnosticsToggle<CR>', { desc = 'Diagnostic Toggle' })
vim.keymap.set('n', '<leader>ul', function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = 'Toggle Line Numbers' })

-- Buffer keymaps
-- Delete all buffers except current
vim.keymap.set('n', '<leader>bD', function()
  vim.notify('Deleting all buffers except current', vim.log.levels.INFO, { timeout = 500 })
  local current = vim.api.nvim_get_current_buf()
  for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
    if buffer ~= current then
      vim.api.nvim_buf_delete(buffer, {})
    end
  end
end, { desc = 'Delete all buf except current' })
vim.keymap.set('n', '<C-s>', function()
  vim.cmd(':w')
end, { desc = 'Save' })
vim.keymap.set('i', '<C-s>', function()
  -- escape to normal mode and save
  vim.cmd('stopinsert')
  vim.cmd(':w')
end, { desc = 'Save' })

-- Window Keymaps
-- Move to window using the <ctrl> hjkl keys
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to left window', remap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window', remap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window', remap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to right window', remap = true })
-- Diagnostic keymaps
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump({ count = -1 })
end, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump({ count = 1 })
end, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', ']]', '<Plug>(MatchitNormalMultiForward)', { desc = 'Go to next block' })
vim.keymap.set('n', '[[', '<Plug>(MatchitNormalMultiBackward)', { desc = 'Go to previous block' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
-- better indenting
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true, silent = true })

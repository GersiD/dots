-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set('n', '<C-v>', '"+p', { desc = 'Paste from system clipboard' })
vim.keymap.set('i', '<C-v>', function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
  vim.cmd('normal! "+p')
end, { desc = 'Paste from system clipboard' })
vim.keymap.set('v', '<C-c>', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set('n', '<A-j>', '15j', {})
vim.keymap.set('n', '<A-k>', '15k', {})
-- vim.keymap.set("n", "<cr>", "ciw", { remap = true, desc = "Change word" })
vim.keymap.set({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>', { desc = 'Escape and Clear hlsearch' })
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

-- LSP keymaps
vim.keymap.set('n', '<leader>la', function()
  local curr_row = vim.api.nvim_win_get_cursor(0)[1]
  vim.lsp.buf.code_action({
    ['range'] = {
      ['start'] = { curr_row, 0 },
      ['end'] = { curr_row, 1000 },
    },
  })
end, { desc = 'Code Action on Line' })
vim.keymap.set('n', '<leader>ll', vim.lsp.codelens.run, { desc = 'LSP CodeLens' })
vim.keymap.set('n', '<leader>lL', vim.lsp.codelens.refresh, { desc = 'Refresh CodeLens' })
vim.keymap.set('n', '<leader>li', '<cmd>LspInfo<cr>', { desc = 'LSP Info' })
vim.keymap.set('n', '<leader>lS', '<cmd>LspStart<cr>', { desc = 'LSP Start' })
vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, { desc = 'LSP Diag' })
-- vim.keymap.set("n", "<leader>lf", require("lazyvim.plugins.lsp.format").format, { desc = "LSP Format" })
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { desc = 'LSP Rename' })
vim.keymap.set('n', 'gt', function()
  -- I want <CR> to open the selection in a vertical split
  require('telescope.builtin').lsp_type_definitions(require('telescope.themes').get_cursor({
    jump_type = 'vsplit',
    reuse_win = true,
    initial_mode = 'normal',
    attach_mappings = function(_, map)
      map('n', '<CR>', require('telescope.actions').select_vertical)
      return true
    end,
  }))
end, { desc = 'LSP Type Definitions' })
vim.keymap.set('n', 'gd', function()
  require('telescope.builtin').lsp_definitions(require('telescope.themes').get_cursor({
    reuse_win = true,
    attach_mappings = function(_, map)
      map('n', '<CR>', require('telescope.actions').select_vertical)
      return true
    end,
  }))
end, { desc = 'LSP Definitions' })
vim.keymap.set('n', 'gs', function()
  require('telescope.builtin').lsp_definitions(require('telescope.themes').get_cursor({
    jump_type = 'vsplit',
    reuse_win = false,
    initial_mode = 'normal',
    attach_mappings = function(_, map)
      map('n', '<CR>', require('telescope.actions').select_vertical)
      return true
    end,
  }))
end, { desc = 'LSP Definitions Split' })
vim.keymap.set('n', '<leader>fs', function()
  require('telescope.builtin').treesitter()
end, { desc = 'Find Symbols' })
vim.keymap.set('n', 'gi', function()
  require('telescope.builtin').lsp_implementations(
    require('telescope.themes').get_cursor({ jump_type = 'vsplit', reuse_win = true })
  )
end, { desc = 'LSP Implementations' })
vim.keymap.set('n', '<leader>uf', '<CMD>KickstartFormatToggle<CR>', { desc = 'Format Toggle' })
vim.keymap.set('n', '<leader>ud', '<CMD>KickstartDiagnosticsToggle<CR>', { desc = 'Diagnostic Toggle' })
vim.keymap.set('n', '<leader>ul', function()
  local current = vim.opt.relativenumber:get()
  vim.opt.relativenumber = not current
end, { desc = 'Toggle Line Numbers' })
vim.keymap.set('n', 'gr', function()
  require('telescope.builtin').lsp_references(
    require('telescope.themes').get_cursor({ jump_type = 'vsplit', reuse_win = true })
  )
end, { desc = 'Goto References' })
vim.keymap.set('n', 'gD', function()
  -- if lsp supports declaration, go to declaration
  if vim.lsp.get_clients({ method = 'textDocument/declaration' })[1] then
    vim.lsp.buf.declaration()
  else
    vim.lsp.buf.definition()
  end
end, { desc = 'Goto Declaration' })

-- DAP Keymaps
vim.keymap.set('n', '<F7>', function()
  require('dap').step_out()
end, { desc = 'DAP Step Out' })
vim.keymap.set('n', '<F8>', function()
  require('dap').continue()
end, { desc = 'DAP Continue' })
vim.keymap.set('n', '<F9>', function()
  require('dap').step_into()
end, { desc = 'DAP Step Into' })
vim.keymap.set('n', '<F10>', function()
  require('dap').step_over()
end, { desc = 'DAP Step Over' })
vim.keymap.set('n', 'K', function()
  local dap_open = require('dap').session() ~= nil
  if dap_open then
    require('dapui').eval()
  else
    vim.lsp.buf.hover()
  end
end, { desc = 'DAP Eval' })

-- Buffer keymaps
-- Delete all buffers except current
vim.keymap.set('n', '<leader>bD', function()
  vim.notify('Deleting all buffers except current', 'info', { timeout = 500 })
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
  -- send esc key to exit from insert mode
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
  vim.cmd(':w')
end, { desc = 'Save' })
-- Fuzzy search all open buffers
vim.keymap.set('n', '<leader>bf', function()
  require('telescope.builtin').buffers({
    ignore_current_buffer = true,
    sort_mru = true,
    attach_mappings = function(_, map)
      map('n', 'dd', function(prompt_bufnr)
        require('telescope.actions').delete_buffer(prompt_bufnr)
      end)
      return true
    end,
  })
end, { desc = 'Find Buffer' })

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
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
-- better indenting
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true, silent = true })

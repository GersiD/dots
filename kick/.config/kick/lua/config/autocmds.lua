-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd('BufHidden', {
  desc = 'Delete [No Name] buffers',
  callback = function(event)
    if event.file == '' and vim.bo[event.buf].buftype == '' and not vim.bo[event.buf].modified then
      vim.schedule(function()
        pcall(vim.api.nvim_buf_delete, event.buf, {})
      end)
    end
  end,
})

-- Treesitter automatic Python format strings
vim.api.nvim_create_augroup('py-fstring', { clear = true })
vim.api.nvim_create_autocmd('InsertCharPre', {
  pattern = { '*.py' },
  group = 'py-fstring',
  --- @param opts table | string
  --- @return nil
  callback = function(opts)
    -- Only run if f-string escape character is typed
    if vim.v.char ~= '{' then
      return
    end
    -- Get node and return early if not in a string
    local node = vim.treesitter.get_node()
    if not node then
      return
    end
    if node:type() ~= 'string' then
      node = node:parent()
    end
    if not node or node:type() ~= 'string' then
      return
    end

    -- vim.notify(node:type())
    local row, col, _, _ = vim.treesitter.get_node_range(node)

    -- Return early if string is already a format string
    local first_char = vim.api.nvim_buf_get_text(opts.buf, row, col, row, col + 1, {})[1]
    -- vim.notify('row ' .. row .. ' col ' .. col)
    -- vim.notify("char: '" .. first_char .. "'")
    if first_char == 'f' then
      return
    end

    -- Otherwise, make the string a format string
    -- vim.notify('fstring')
    vim.api.nvim_input("<Esc>m'" .. row + 1 .. 'gg' .. col + 1 .. "|if<Esc>`'la")
  end,
})
-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  group = vim.api.nvim_create_augroup('last_loc', { clear = true }),
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
-- Set keymap on PNG files to open in image preview
vim.api.nvim_create_autocmd('BufRead', {
  pattern = '*.png',
  callback = function()
    vim.keymap.set('n', '<leader>1', function()
      vim.cmd('!eog ' .. vim.fn.expand('%'))
    end, { buffer = 0 })
  end,
})

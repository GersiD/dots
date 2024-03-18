-- Create autocmd for entering csv files, we want to open them using csvlens
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = '*.csv',
  desc = 'Setup CSV LSP',
  callback = function()
    vim.keymap.set('n', '<leader><esc>', function()
      require("config.utils.terminals").run("csvlens " .. vim.fn.expand("%"))
    end, { desc = 'Open CSV File' })
  end,
})

return {}

return {
  'tzachar/highlight-undo.nvim',
  keys = { 'u', '<C-r>' },
  event = 'BufRead',
  config = function()
    require('highlight-undo').setup({
      hlgroup = 'HighlightUndo',
      duration = 300,
    })
  end,
}

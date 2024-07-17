return {
  {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    enabled = false,
    event = 'BufReadPre',
    config = function()
      require('lsp_lines').setup()
    end,
  },
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy',
    config = function()
      require('tiny-inline-diagnostic').setup({
        options = {
          multiple_diag_under_cursor = true,
        },
      })
    end,
  },
}

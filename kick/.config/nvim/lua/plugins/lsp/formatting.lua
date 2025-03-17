return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  dependencies = { 'mason.nvim' },
  opts = function()
    ---@type conform.setupOpts
    local opts = {
      default_format_opts = {
        timout_ms = 1000,
        async = false,
        quiet = false,
        lsp_format = 'fallback',
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        fish = { 'fish_indent' },
        sh = { 'shfmt' },
        -- markdown = { 'prettier' },
      },
    }
    return opts
  end,
  keys = {
    {
      '<leader>lf',
      function()
        require('conform').format({ bufnr = 0, lsp_format = 'fallback' })
      end,
      desc = 'LSP: Conform Format',
    },
  },
}

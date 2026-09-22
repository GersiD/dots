return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  dependencies = { 'mason.nvim' },
  opts = function()
    ---@type conform.setupOpts
    local opts = {
      default_format_opts = {
        timeout_ms = 500,
        async = false,
        quiet = false,
        lsp_format = 'fallback',
      },
      format_on_save = function()
        if vim.g.format_is_enabled == false then
          return nil
        end
        return { timeout_ms = 500, lsp_format = 'fallback' }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        fish = { 'fish_indent' },
        sh = { 'shfmt' },
        tex = { 'tex-fmt' },
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

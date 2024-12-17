return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  dependencies = { 'mason.nvim' },
  opts = function()
    ---@type conform.setupOpts
    local opts = {
      default_format_opts = {
        timout_ms = 3000,
        async = false,
        quiet = false,
        lsp_format = 'fallback',
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        fish = { 'fish_indent' },
        sh = { 'shfmt' },
      },
      -- format_on_save = { -- I have one already setup in nvim_lsp_config
      --   timeout_ms = 1000,
      --   lsp_format = 'fallback',
      -- },
    }
    return opts
  end,
}

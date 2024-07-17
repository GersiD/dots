return {
  'mrcjkb/rustaceanvim',
  version = '^4', -- Recommended
  ft = { 'rust' },
  opts = {
    -- plugin config
    tools = {
      runnables = {
        use_telescope = true,
      },
    },
    -- LSP config
    server = {
      on_attach = function(_, bufnr)
        vim.keymap.set('n', '<leader>la', function()
          vim.cmd.RustLsp('codeAction')
        end, { desc = 'Rust Tools Code Action', buffer = bufnr })
        vim.keymap.set('n', '<leader><esc>', function()
          require('config.utils.terminals').run('time cargo run', { direction = 'float' })
        end, { desc = 'Run Rust Proj', buffer = true })
        vim.keymap.set('n', '<leader>1', function()
          require('config.utils.terminals').run('time cargo test', { direction = 'float' })
        end, { desc = 'Run Rust Proj', buffer = true })
        vim.keymap.set('n', '<leader>lt', function()
          require('config.utils.terminals').run('time cargo test')
        end, { desc = 'LSP Test' })
        vim.keymap.set('n', 'K', function()
          vim.lsp.buf.hover()
        end, { desc = 'Rust Tools Hover', buffer = bufnr })
        require('null-ls').register({
          require('null-ls').builtins.formatting.rustfmt,
        })
        -- set timout to nil
        require('null-ls.config').get().default_timeout = 10000
      end,

      default_settings = {
        ['rust-analyzer'] = {
          assist = {
            importGranularity = 'module',
            importPrefix = 'by_self',
          },
          check = {
            command = 'clippy',
            features = 'all',
          },
          checkOnSave = { -- just in case the above is wrong
            command = 'clippy',
            allFeatures = true,
            extraArgs = { '--no-deps' },
          },
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
            runBuildScripts = true,
            features = 'all',
          },
          procMacro = { -- What does this do?
            enable = true,
            ignored = {
              ['async-trait'] = { 'async_trait' },
              ['napi-derive'] = { 'napi' },
              ['async-recursion'] = { 'async_recursion' },
            },
          },
        },
      },
    },
    -- DAP config
    dap = {},
  },
  config = function(_, opts)
    vim.g.rustaceanvim = vim.tbl_deep_extend('keep', vim.g.rustaceanvim or {}, opts or {})
  end,
}

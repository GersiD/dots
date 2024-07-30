-- Correctly setup lspconfig for clangd 🚀
return {
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'p00f/clangd_extensions.nvim' },
    opts = {
      servers = {
        -- Ensure mason installs the server
        clangd = {
          root_dir = function(fname)
            return require('lspconfig.util').root_pattern(
              'Makefile',
              'configure.ac',
              'configure.in',
              'config.h.in',
              'meson.build',
              'meson_options.txt',
              'build.ninja'
            )(fname) or require('lspconfig.util').root_pattern('compile_commands.json', 'compile_flags.txt')(
              fname
            ) or require('lspconfig.util').find_git_ancestor(fname)
          end,
          capabilities = {
            offsetEncoding = { 'utf-16' },
          },
          cmd = {
            'clangd',
            '--background-index',
            '--clang-tidy',
            '--header-insertion=iwyu',
            '--completion-style=detailed',
            '--function-arg-placeholders',
            '--fallback-style=llvm',
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
          on_attach = function(_, opts)
            require('clangd_extensions').setup(vim.tbl_deep_extend('force', {}, { server = opts }))
            -- vim.notify('Setup clangd extension', 'info', { title = 'LSP' })
            return false
          end,
        },
      },
    },
  },
  {
    'nvim-cmp',
    opts = function(_, opts)
      table.insert(opts.sorting.comparators, 1, require('clangd_extensions.cmp_scores'))
    end,
  },
}

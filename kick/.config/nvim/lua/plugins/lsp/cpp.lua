-- Correctly setup lspconfig for clangd 🚀
return {
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'p00f/clangd_extensions.nvim' },
    opts = {
      servers = {
        -- Ensure mason installs the server
        clangd = {
          -- Nested lists are priority tiers: earlier tiers win.
          root_markers = {
            { 'Makefile', 'configure.ac', 'configure.in', 'config.h.in', 'meson.build', 'meson_options.txt', 'build.ninja' },
            { 'compile_commands.json', 'compile_flags.txt' },
            '.git',
          },
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
        },
      },
    },
  },
  -- {
  --   'nvim-cmp',
  --   opts = function(_, opts)
  --     table.insert(opts.sorting.comparators, 1, require('clangd_extensions.cmp_scores'))
  --   end,
  -- },
}

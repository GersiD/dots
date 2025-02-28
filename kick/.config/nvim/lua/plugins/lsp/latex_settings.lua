return {
  {
    'lervag/vimtex',
    lazy = false,
    config = function()
      vim.api.nvim_create_autocmd({ 'BufEnter' }, {
        pattern = '*.tex',
        desc = 'Setup Vimtex',
        once = true,
        callback = function()
          vim.cmd('TSDisable highlight')
          vim.cmd('VimtexCompile')
        end,
      })
      vim.g.vimtex_compiler_latexmk = {
        build_dir = 'build',
        aux_dir = 'build',
        -- out_dir = "build",
      }
      vim.g.vimtex_compiler_method = 'latexmk'
      vim.g.vimtex_quickfix_open_on_warning = false
      vim.g.vimtex_quickfix_ignore_filters = { 'Underfull', 'Overfull' }
      vim.g.vimtex_fold_manual = 1 -- faster
      vim.g.vimtex_fold_enabled = 0
      vim.g.vimtex_fold_bib_enabled = 0
      vim.g.vimtex_matchparen_enabled = 0
      vim.g.vimtex_delim_timeout = 100
      vim.g.vimtex_delim_insert_timeout = 40
      vim.g.vimtex_delim_stopline = 20
      vim.g.vimtex_doc_enabled = 0
      vim.g.vimtex_complete_enabled = 0
      vim.g.vimtex_format_enabled = 0
      vim.g.vimtex_include_search_enabled = 0
      vim.g.vimtex_motion_enabled = 0
      vim.g.vimtex_syntax_enabled = 0
      vim.g.vimtex_syntax_conceal_disable = 1
      vim.g.vimtex_toc_enabled = 0
      -- vim.api.nvim_create_autocmd({ 'BufEnter' }, {
      --   pattern = '*.tex',
      --   desc = 'setup_omni',
      --   once = true,
      --   callback = function()
      --     -- Use omnifunc for completion
      --     local cmp = require('cmp')
      --     local sources = cmp.get_config().sources
      --     local addOmni = { name = 'omni', priority = 500 }
      --     vim.list_extend(sources, { addOmni })
      --     cmp.setup.buffer({ sources = sources })
      --   end,
      -- })
      if jit.os == 'Windows' then
        return {
          ['vimtex_view_general_viewer'] = 'C:/Users/gersi/AppData/Local/Microsoft/WindowsApps/SumatraPDF.exe',
          ['vimtex_view_method'] = 'C:/Users/gersi/AppData/Local/Microsoft/WindowsApps/SumatraPDF.exe',
          ['vimtex_view_general_options'] = '-reuse-instance -forward-search @tex @line @pdf',
          ['vimtex_view_general_options_latexmk'] = '-reuse-instance',
        }
      else
        vim.g.vimtex_view_general_viewer = 'zathura'
        vim.g.vimtex_view_method = 'zathura'
        vim.g.vimtex_complete_enabled = 0 -- Disable completion from vimmtex (slow)
        vim.g.vimtex_complete_bib = 0
        vim.g.vimtex_complete_close_braces = 0
        vim.g.vimtex_complete_enabled = 0
        vim.g.vimtex_complete_ignore_case = 0
        vim.g.vimtex_complete_ref = 0
        vim.g.vimtex_complete_smart_case = 0
        return {
          -- ['vimtex_view_general_viewer'] = 'mupdf',
          -- ['vimtex_view_method'] = 'mupdf',
          -- ['vimtex_view_general_options'] = '',
          -- ['vimtex_view_general_options_latexmk'] = '',
        }
      end
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        texlab = {
          mason = false,
          settings = {
            texlab = {
              inlayHints = {
                labelReferences = false,
              },
              chktex = {
                onEdit = false, -- default value
                onOpenAndSave = false,
              },
              latexindent = {
                modifyLineBreaks = false,
              },
              -- formatterLineLength = 10, -- doesnt work aparently
            },
          },
        },
        ltex = {
          -- mason = false,
          autostart = false,
          settings = {
            ltex = {
              checkFrequency = 'save',
              language = 'en-US',
              diagnosticSeverity = 'hint',
              completionEnabled = true,
              dictionary = {
                ['en-US'] = {
                  'Gersi',
                  'Doko',
                  'CVaR',
                  'Palash',
                  'Petrik',
                  'VaR',
                  'CVaR',
                  'Neovim',
                  'Zettelkasten',
                  'LPAL',
                  'EVaR',
                  'monotonicity',
                  'functionals',
                  'supremum',
                  'Expectile',
                  'OCE',
                  'Monkie',
                },
              },
            },
          },
        },
      },
    },
  },
}

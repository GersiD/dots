return {
  'neovim/nvim-lspconfig',
  -- Per-server settings live in after/lsp/<server>.lua; after/ is needed so they override
  -- the defaults nvim-lspconfig ships in its own lsp/ directory.
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    { 'mason-org/mason.nvim',           opts = {} },
    -- set up once in config below; lazy's automatic setup({}) would enable servers before `exclude` applies
    'mason-org/mason-lspconfig.nvim',
    -- loading blink registers its completion capabilities for every server before any starts
    'saghen/blink.cmp',
    { 'folke/neoconf.nvim',             cmd = 'Neoconf', config = false, dependencies = { 'nvim-lspconfig' } },
  },
  event = 'BufReadPre',
  config = function()
    -- Register Command LspLog to open the LSP log file
    vim.api.nvim_create_user_command('LspLog', function()
      local log_path = vim.lsp.log.get_filename()
      if log_path then
        vim.cmd('edit ' .. log_path)
      else
        print('No LSP log file found')
      end
    end, {})
    -- Change the Diagnostic symbols
    local diagnostic_type_icon = require('config.icons').diagnostics
    vim.diagnostic.config({
      virtual_text = {
        severity = {
          max = vim.diagnostic.severity.WARN,
        },
      },
      virtual_lines = {
        severity = {
          min = vim.diagnostic.severity.ERROR,
        },
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = diagnostic_type_icon.Error,
          [vim.diagnostic.severity.WARN] = diagnostic_type_icon.Warn,
          [vim.diagnostic.severity.INFO] = diagnostic_type_icon.Info,
          [vim.diagnostic.severity.HINT] = diagnostic_type_icon.Hint,
        },
        texthl = {
          [vim.diagnostic.severity.ERROR] = 'DiagnosticError',
          [vim.diagnostic.severity.WARN] = 'DiagnosticWarn',
          [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
          [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
        },
      },
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })

    -- Switch for controlling whether you want autoformatting.
    --  Use :KickstartFormatToggle to toggle autoformatting on or off
    vim.g.format_is_enabled = true
    vim.api.nvim_create_user_command('KickstartFormatToggle', function()
      vim.g.format_is_enabled = not vim.g.format_is_enabled
      print('AutoFormat = ' .. tostring(vim.g.format_is_enabled))
    end, {})
    vim.api.nvim_create_user_command('KickstartFormatDisable', function()
      vim.g.format_is_enabled = false
      print('AutoFormat = ' .. tostring(vim.g.format_is_enabled))
    end, {})

    -- Switch for controlling wheter you want diagnostics.
    -- Use :KickstartDiagnosticsToggle to toggle diagnostics on or off
    local diagnostics_are_enabled = true
    vim.api.nvim_create_user_command('KickstartDiagnosticsToggle', function()
      diagnostics_are_enabled = not diagnostics_are_enabled
      if diagnostics_are_enabled then
        vim.diagnostic.enable(true)
      else
        vim.diagnostic.enable(false)
      end
      print('Diagnostics = ' .. tostring(diagnostics_are_enabled))
    end, {})

    -- Whenever an LSP attaches to a buffer, we will run this function.
    --
    -- See `:help LspAttach` for more information about this autocmd event.
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach-format', { clear = true }),
      -- This is where we attach the autoformatting for reasonable clients
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
          return
        end
        local bufnr = args.buf
        -- Check if should skip client
        if client.config.skip_custom_attach then
          return
        end

        -- Enable inlay hints
        if client:supports_method('textDocument/inlayHint') and not client.config.skip_inlay then
          vim.lsp.inlay_hint.enable(true)
        end
        local function nmap(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        -- LSP keymaps
        -- Lesser used LSP functionality
        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        nmap('<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')
        nmap('gD', function()
          -- if lsp supports declaration, go to declaration
          if vim.lsp.get_clients({ method = 'textDocument/declaration' })[1] then
            vim.lsp.buf.declaration()
          else
            vim.lsp.buf.definition()
          end
        end, 'Goto Declaration')
        nmap('gr', function()
          require('fzf-lua').lsp_references()
        end, 'Goto References')
        nmap('<leader>la', function()
          local curr_row = vim.api.nvim_win_get_cursor(0)[1]
          vim.lsp.buf.code_action({
            ['range'] = {
              ['start'] = { curr_row, 0 },
              ['end'] = { curr_row, 1000 },
            },
          })
        end, 'Code Action on Line')
        nmap('<leader>ll', vim.lsp.codelens.run, 'CodeLens')
        nmap('<leader>lL', vim.lsp.codelens.refresh, 'Refresh CodeLens')
        nmap('<leader>li', '<cmd>LspInfo<cr>', 'Info')
        nmap('<leader>lS', '<cmd>LspStart<cr>', 'Start')
        nmap('<leader>ld', vim.diagnostic.open_float, 'Diag')
        nmap('<leader>lr', vim.lsp.buf.rename, 'Rename')
        nmap('gt', function()
          -- I want <CR> to open the selection in a vertical split
          require('fzf-lua').lsp_typedefs({
            jump_type = 'vsplit',
            reuse_win = true,
            initial_mode = 'normal',
            attach_mappings = function(_, map)
              map('n', '<CR>', require('telescope.actions').select_vertical)
              return true
            end
          })
        end, 'Type Definitions')
        -- Only map 'gd' if definitionProvider is supported
        if client:supports_method('textDocument/definition') then
          nmap('gd', function()
            require('fzf-lua').lsp_definitions({
              jump_type = 'vsplit',
              reuse_win = true,
              initial_mode = 'normal',
            })
          end, 'Definitions')
        end
        nmap('gs', function()
          require('fzf-lua').lsp_definitions({
            jump_type = 'vsplit',
            reuse_win = false,
            initial_mode = 'normal',
          })
        end, 'Definitions Split')
        nmap('<leader>fs', function()
          require('fzf-lua').treesitter()
        end, 'Find Symbols')
        nmap('gi', function()
          require('fzf-lua').lsp_implementations()
        end, 'Implementations')
      end,
    })
    require('mason-lspconfig').setup({
      ensure_installed = { 'clangd', 'lua_ls' },
      -- rustaceanvim owns rust_analyzer; ltex_plus is started by hand from the tex/markdown ftplugins
      automatic_enable = { exclude = { 'rust_analyzer', 'ltex_plus' } },
    })
    -- not installed through mason
    vim.lsp.enable({ 'julials', 'texlab' })
  end,
}

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    { 'williamboman/mason.nvim', opts = {} },
    { 'williamboman/mason-lspconfig.nvim', opts = {} },
    { 'folke/neoconf.nvim', cmd = 'Neoconf', config = false, dependencies = { 'nvim-lspconfig' } },

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
  },
  event = 'BufReadPre',
  opts = {
    -- LSP Server Settings
    servers = {
      lua_ls = {
        -- mason = false, -- set to false if you don't want this server to be installed with mason
        -- Use this to add any additional keymaps
        -- for specific lsp servers
        ---@type LazyKeys[]
        -- keys = {},
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            -- → Lua.format.enable                   default: true
            format = {
              enable = false,
            },
            completion = {
              callSnippet = 'Replace',
            },
          },
        },
      },
      rust_analyzer = {
        mason = false,
      },
      julials = {
        -- cmd = { 'echo "hi"' }, -- NOTE: This works
        mason = false,
        settings = { -- WARN: Doesnt work
          julia = {
            NumThreads = 4,
            execution = {
              codeInREPL = true,
            },
            format = {
              -- comments = false,
              indents = 1,
            },
          },
        },
      },
    },
    setup = {
      rust_analyzer = function()
        return true -- return true to skip the default setup
      end,
    },
  },
  config = function(_, opts)
    -- Change the Diagnostic symbols
    local diagnostic_type_icon = require('config.icons').diagnostics
    vim.diagnostic.config({
      virtual_text = true,
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
    local format_is_enabled = true
    vim.api.nvim_create_user_command('KickstartFormatToggle', function()
      format_is_enabled = not format_is_enabled
      print('AutoFormat = ' .. tostring(format_is_enabled))
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

    -- Create an augroup that is used for managing our formatting autocmds.
    --      We need one augroup per client to make sure that multiple clients
    --      can attach to the same buffer without interfering with each other.
    local _augroups = {}
    local get_augroup = function(client)
      if not _augroups[client.id] then
        local group_name = 'kickstart-lsp-format-' .. client.name
        local id = vim.api.nvim_create_augroup(group_name, { clear = true })
        _augroups[client.id] = id
      end

      return _augroups[client.id]
    end

    -- Whenever an LSP attaches to a buffer, we will run this function.
    --
    -- See `:help LspAttach` for more information about this autocmd event.
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach-format', { clear = true }),
      -- This is where we attach the autoformatting for reasonable clients
      callback = function(args)
        local client_id = args.data.client_id
        local client = vim.lsp.get_client_by_id(client_id) or {}
        local bufnr = args.buf

        -- Enable inlay hints
        local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
        if client.supports_method('textDocument/inlayHint') then
          inlay_hint.enable(true)
        end

        -- Only attach to clients that support document formatting
        if not client.server_capabilities.documentFormattingProvider then
          return
        end
        local function nmap(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        -- Lesser used LSP functionality
        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        nmap('<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')

        -- Create an autocmd that will run *before* we save the buffer.
        --  Run the formatting command for the LSP that has just attached.
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = get_augroup(client),
          buffer = bufnr,
          callback = function()
            if format_is_enabled then
              require('conform').format({ bufnr = bufnr, lsp_format = 'fallback' })
            end
          end,
        })
      end,
    })
    -- local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    local has_blink, blink = pcall(require, 'blink.cmp')
    local capabilities = vim.tbl_deep_extend(
      'force',
      {},
      vim.lsp.protocol.make_client_capabilities(),
      -- has_cmp and cmp_nvim_lsp.default_capabilities() or {},
      has_blink and blink.get_lsp_capabilities() or {},
      opts.capabilities or {}
    )
    capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
    capabilities.textDocument.completion.completionItem.preselectSupport = true
    capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown' }
    capabilities.textDocument.codeAction = {
      dynamicRegistration = true,
      codeActionLiteralSupport = {
        codeActionKind = {
          valueSet = (function()
            local res = vim.tbl_values(vim.lsp.protocol.CodeActionKind)
            table.sort(res)
            return res
          end)(),
        },
      },
    }

    -- CONFIGS
    local servers = opts.servers or {}
    local function setup(server)
      local server_opts = vim.tbl_deep_extend('force', {
        capabilities = vim.deepcopy(capabilities or {}),
      }, servers[server] or {})

      if opts.setup[server] then
        if opts.setup[server](server, server_opts) then
          return
        end
      elseif opts.setup['*'] then
        if opts.setup['*'](server, server_opts) then
          return
        end
      end
      require('lspconfig')[server].setup(server_opts)
    end

    -- get all the servers that are available through mason-lspconfig
    local all_mslp_servers = vim.tbl_keys(require('mason-lspconfig.mappings.server').lspconfig_to_package)
    local ensure_installed = {} ---@type string[]
    for server, server_opts in pairs(servers) do
      if server_opts then
        server_opts = server_opts == true and {} or server_opts
        -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
        if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
          setup(server)
        else
          ensure_installed[#ensure_installed + 1] = server
        end
      end
    end

    require('mason-lspconfig').setup({ ensure_installed = ensure_installed, handlers = { setup } })
  end,
}

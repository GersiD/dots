return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Installs the debug adapters for you
    'mason-org/mason.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',

    -- fancy UI for the debugger
    {
      'rcarriga/nvim-dap-ui',
    },

    -- virtual text for the debugger
    {
      'theHamsta/nvim-dap-virtual-text',
      opts = {},
    },

    -- which key integration
    {
      'folke/which-key.nvim',
      optional = true,
      opts = {
        defaults = {
          ['<leader>d'] = { name = '+debug' },
          ['<leader>da'] = { name = '+adapters' },
        },
      },
    },

    -- mason.nvim integration
    {
      'jay-babu/mason-nvim-dap.nvim',
      dependencies = 'mason.nvim',
      cmd = { 'DapInstall', 'DapUninstall' },
      opts = {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
        },
      },
    },
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    require('mason-nvim-dap').setup({
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
      },
    })

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
    end, { desc = 'Debug: Set Breakpoint' })
    -- DAP Keymaps
    vim.keymap.set('n', '<F7>', require('dap').step_out, { desc = 'DAP Step Out' })
    vim.keymap.set('n', '<F8>', require('dap').continue, { desc = 'DAP Continue' })
    vim.keymap.set('n', '<F9>', require('dap').step_into, { desc = 'DAP Step Into' })
    vim.keymap.set('n', '<F10>', require('dap').step_over, { desc = 'DAP Step Over' })
    vim.keymap.set('n', 'K', function()
      local dap_open = dap.session() ~= nil
      if dap_open then
        require('dapui').eval()
      else
        vim.lsp.buf.hover()
      end
    end, { desc = 'DAP Eval' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
    vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })
    local dap_icons = require('config.icons').dap
    for name, sign in pairs(dap_icons) do
      sign = type(sign) == 'table' and sign or { sign }
      vim.fn.sign_define(
        'Dap' .. name,
        { text = sign[1], texthl = sign[2] or 'DiagnosticInfo', linehl = sign[3], numhl = sign[3] }
      )
    end
    -- Install golang specific config
    require('dap-go').setup()
  end,
  -- stylua: ignore
  keys = {
    {
      "<leader>dB",
      function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
      desc =
      "Breakpoint Condition"
    },
    {
      "<leader>db",
      function() require("dap").toggle_breakpoint() end,
      desc =
      "Toggle Breakpoint"
    },
    {
      "<leader>dc",
      function() require("dap").continue() end,
      desc =
      "Continue"
    },
    {
      "<leader>dC",
      function() require("dap").run_to_cursor() end,
      desc =
      "Run to Cursor"
    },
    {
      "<leader>dg",
      function() require("dap").goto_() end,
      desc =
      "Go to line (no execute)"
    },
    {
      "<leader>di",
      function() require("dap").step_into() end,
      desc =
      "Step Into"
    },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end,   desc = "Up" },
    {
      "<leader>dl",
      function() require("dap").run_last() end,
      desc =
      "Run Last"
    },
    {
      "<leader>do",
      function() require("dap").step_out() end,
      desc =
      "Step Out"
    },
    {
      "<leader>dO",
      function() require("dap").step_over() end,
      desc =
      "Step Over"
    },
    { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
    {
      "<leader>dr",
      function() require("dap").repl.toggle() end,
      desc =
      "Toggle REPL"
    },
    {
      "<leader>ds",
      function() require("dap").session() end,
      desc =
      "Session"
    },
    {
      "<leader>dt",
      function() require("dap").terminate() end,
      desc =
      "Terminate"
    },
    {
      "<leader>dw",
      function() require("dap.ui.widgets").hover() end,
      desc =
      "Widgets"
    },
  },
}

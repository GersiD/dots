return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = { --NOTE: For some reason this caused blink cmdline completion to fail?
      enabled = false,
      preset = {
        keys = {
          { icon = ' ', key = 'f', desc = 'Find File', action = ':Telescope find_files' },
          { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
          { icon = ' ', key = 'r', desc = 'Recent Files', action = ':Telescope oldfiles' },
          {
            icon = ' ',
            key = 'g',
            desc = 'Git',
            action = ':lua require("config.utils.terminals").lazygit()',
          },
          { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
          {
            icon = ' ',
            key = 'S',
            desc = 'Restore SessionS',
            action = ":lua require('snacks').picker.projects()",
          },
          { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
      },
      sections = {
        { section = 'header' },
        { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
        { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
        { section = 'startup' },
      },
    },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    scope = { enabled = true },
    picker = { enabled = true },
  },
  -- stylua: ignore
  keys = {
    { "<leader>nn", function()
        Snacks.notifier.show_history()
    end, desc = "Notification History" },
    { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
  },
}

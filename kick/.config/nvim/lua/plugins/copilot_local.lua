return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    build = ':Copilot auth',
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = { accept = '<Right>' },
      },
      panel = {
        enabled = false,
      },
      filetypes = {
        markdown = true,
        help = true,
      },
      server_opts_overrides = {
        skip_custom_attach = true, -- skip custom attach for this server
      },
    },
  },
}

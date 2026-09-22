return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    build = ':Copilot auth',
    opts = {
      suggestion = {
        auto_trigger = true,
        -- plugin default is 15ms, which fires a request on ~every keystroke;
        -- 150ms lines requests up with actual typing pauses
        debounce = 150,
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

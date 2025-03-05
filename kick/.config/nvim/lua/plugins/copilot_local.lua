return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    -- TODO: This was causing issues RPC[Error] code_name = ServerNotInitialized, message = "Agent service not initialized."
    -- https://github.com/zbirenbaum/copilot.lua/issues/321
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
        help = false,
      },
    },
  },
}

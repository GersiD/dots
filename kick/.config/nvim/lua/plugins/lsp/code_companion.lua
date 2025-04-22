return {

  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  cmd = { 'CodeCompanion', 'CodeCompanionCmd', 'CodeCompanionChat' },
  opts = {
    adapters = {
      deepseek7b = function()
        return require('codecompanion.adapters').extend('ollama', {
          name = 'deepseek7b', -- Give this adapter a different name to differentiate it from the default ollama adapter
          schema = {
            model = {
              default = 'deepseek-r1:8b',
            },
          },
        })
      end,
    },
    strategies = {
      chat = {
        adapter = 'deepseek7b',
      },
    },
  },
}

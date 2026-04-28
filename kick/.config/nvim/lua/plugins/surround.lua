return {
  {
    'kylechui/nvim-surround',
    -- keys = { 's', 'd', 'c' },
    event = 'VeryLazy', -- NOTE: needs to be lazy loaded otherwise keymaps don't work
    ---@type user_options The user options.
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      move_cursor = false,
      surrounds = {
        ['q'] = {
          add = { '"', '"' },
          find = function()
            local config = require('nvim-surround.config')
            return config.get_selection({ motion = 'q' })
          end,
          delete = '^\\s*\\(\\(\\s*\\)\\(\\S\\)\\(.*\\)\\(\\S\\)\\(\\s*\\)\\)\\s*$',
          change = {
            target = '^\\s*\\(\\(\\s*\\)\\(\\S\\)\\(.*\\)\\(\\S\\)\\(\\s*\\)\\)\\s*$',
          },
        },
      },
      aliases = {
        ['s'] = ']', -- Square brackets
        ['p'] = ')', -- Paren
        ['b'] = '}', -- Brackets
        ['m'] = '$', -- Math (latex)
      },
      highlight = {
        duration = 100,
      },
    },
  },
}

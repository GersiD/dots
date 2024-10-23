return {
  {
    'kylechui/nvim-surround',
    keys = { 's', 'd', 'c' },
    ---@type user_options The user options.
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      move_cursor = false,
      keymaps = {
        delete = 'ds',
        change = 'cs',
        change_line = 'cS',
        normal = 's',
        normal_cur_line = 'SS', -- Add surround to the whole line
        visual = 's',
      },
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
        ['p'] = '(', -- Paren
        ['b'] = '}', -- Brackets
        ['m'] = '$', -- Math (latex)
      },
      highlight = {
        duration = 10,
      },
    },
  },
}

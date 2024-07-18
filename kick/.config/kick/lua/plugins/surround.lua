return {
  {
    'kylechui/nvim-surround',
    keys = { 's', 'd', 'c' },
    ---@type user_options The user options.
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      move_cursor = false,
      keymaps = {
        normal = 's',
        normal_cur = 'ss',
        normal_line = 'S',
        normal_cur_line = 'SS',
        visual = 's',
      },
      aliases = {
        ['s'] = ']', -- Square brackets
        ['p'] = ')', -- Paren
        ['b'] = '}', -- Brackets
        ['q'] = '"', -- Quotes
        ['m'] = '$', -- Math (latex)
      },
      highlight = {
        duration = 10,
      },
    },
  },
}

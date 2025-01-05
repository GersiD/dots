return {
  'akinsho/toggleterm.nvim',
  cmd = 'ToggleTerm',
  opts = {
    direction = 'horizontal',
    float_opts = {
      border = 'curved',
      highlights = { border = 'Normal', background = 'Normal' },
      width = vim.o.columns + 10,
      height = vim.o.lines - 5,
    },
    size = function(term)
      if term.direction == 'horizontal' then
        return 20
      elseif term.direction == 'vertical' then
        return vim.o.columns / 2
      end
    end,
    shading_factor = -10,
    -- start_in_insert = true,
    shell = 'pwsh',
  },
}

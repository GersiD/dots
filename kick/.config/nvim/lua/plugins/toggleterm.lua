return {
  'akinsho/toggleterm.nvim',
  cmd = 'ToggleTerm',
  opts = {
    direction = 'horizontal',
    float_opts = {
      border = 'curved',
      highlights = { border = 'Normal', background = 'Normal' },
    },
    size = function(term)
      if term.direction == 'horizontal' then
        return 20
      elseif term.direction == 'vertical' then
        return vim.o.columns / 2
      end
    end,
    shading_factor = -10,
    -- auto_scroll runs `normal! G` in the terminal on every chunk of output, which flips the mode to
    -- nt and back and cancels a half typed <leader> sequence in the code window (e.g. while the julia
    -- REPL prints). Terminal windows already follow output while their cursor is on the last line.
    auto_scroll = false,
    -- start_in_insert = true,
    shell = jit.os == 'Windows' and 'pwsh' or 'fish',
  },
}

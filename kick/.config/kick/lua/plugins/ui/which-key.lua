return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts_extend = { 'spec' },
  ---@type wk.Opts
  opts = {
    ---@type false | "classic" | "modern" | "helix"
    preset = 'modern',
    ---@type wk.Spec
    spec = {
      {
        mode = { 'n', 'v' },
        { 'g', group = 'goto' },
        { '[', group = 'prev' },
        { ']', group = 'next' },
        { '<leader>b', group = 'buffer' },
        { '<leader>l', group = 'code' },
        { '<leader>f', group = 'file/find' },
        { '<leader>t', group = 'terminal' },
        { '<leader>d', group = 'debug' },
        { '<leader>g', group = 'git' },
        { '<leader><tab>', group = 'tabs' },
        { '<leader>s', group = 'search' },
        { '<leader>u', group = 'ui' },
        { '<leader>w', group = 'windows' },
        { '<leader>x', group = 'diagnostics/quickfix' },
        { 'gs', group = 'surround' },
        { 'z', group = 'fold' },
        { '<leader>p', group = 'packages' },
      },
    },
    ---@param mapping wk.Mapping
    filter = function(mapping)
      local disabled = {
        'gbc',
        'gcA',
        'grn',
        'grr',
        'gra',
        'gco',
        'gcO',
        'gcc',
      }
      for _, v in ipairs(disabled) do
        if mapping.lhs == v then
          return false
        end
      end
      return true
    end,
  },
  config = function(_, opts)
    local wk = require('which-key')
    wk.setup(opts)
  end,
}

return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts_extend = { 'spec' },
  ---@type wk.Opts
  opts = {
    ---@type false | "classic" | "modern" | "helix"
    preset = 'modern',
    defaults = {},
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
        { '<leader>w', group = 'workspace' },
        { '<leader>x', group = 'diagnostics/quickfix' },
        { 's', group = 'surround' },
        { 'ds', group = 'surround' },
        { 'z', group = 'fold' },
        { '<leader>p', group = 'packages' },
      },
    },
  },
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show({ global = false })
      end,
      desc = 'Buffer Keymaps (which-key)',
    },
    {
      '<c-w><space>',
      function()
        require('which-key').show({ keys = '<c-w>', loop = true })
      end,
      desc = 'Window Hydra Mode (which-key)',
    },
  },
  config = function(_, opts)
    local wk = require('which-key')
    wk.setup(opts)
  end,
}

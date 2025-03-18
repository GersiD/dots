return {
  'stevearc/quicker.nvim',
  event = 'FileType qf',
  ---@module "quicker"
  ---@type quicker.SetupOptions
  opts = {
    edit = { enabled = true },
    highlight = {
      load_buffers = false,
      treesitter = true,
      lsp = true,
    },
    follow = {
      enabled = true,
    },
    keys = {
      { '>', "<cmd>lua require('quicker').toggle_expand()<CR>", desc = 'Expand quickfix content' },
    },
    max_filename_width = function()
      return 15
    end,
  },
}

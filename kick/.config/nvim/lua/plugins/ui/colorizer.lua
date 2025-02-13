return {
  'NvChad/nvim-colorizer.lua',
  keys = {
    {
      '<leader>uc',
      function()
        if not require('colorizer').is_buffer_attached(0) then
          require('colorizer').attach_to_buffer(0)
          vim.notify(' Colorizer enabled', vim.log.levels.INFO, { title = 'Colorizer' })
        else
          require('colorizer').detach_from_buffer(0)
          vim.notify(' Colorizer disabled', vim.log.levels.INFO, { title = 'Colorizer' })
        end
      end,
      desc = 'UI Colorizer',
    },
  },
  opts = {},
}

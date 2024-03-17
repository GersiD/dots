return {
  'NvChad/nvim-colorizer.lua',
  keys = {
    {
      '<leader>uc',
      function()
        if not require('colorizer').is_buffer_attached(0) then
          require('colorizer').attach_to_buffer(0)
        else
          require('colorizer').detach_from_buffer(0)
        end
      end,
      desc = 'UI Colorizer',
    },
  },
  opts = {},
}

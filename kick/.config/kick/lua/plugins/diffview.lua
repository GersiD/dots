return {
  'sindrets/diffview.nvim',
  cmd = 'DiffviewOpen',
  keys = {
    -- { 'n', '<leader>gd', '<cmd>DiffviewOpen<CR>', { desc = 'Diffview' } },
    {
      '<leader>gH',
      '<cmd>DiffviewFileHistory<CR>',
      desc = 'Stage all',
    },
    {
      '<leader>gd',
      function()
        -- Git Keymaps
        local view = require('diffview.lib').get_current_view()
        if view then
          -- Current tabpage is a Diffview; close it
          vim.cmd(':DiffviewClose')
        else
          -- No open Diffview exists: open a new one
          vim.cmd(':DiffviewOpen')
        end
      end,
      desc = 'Diffview',
    },
  },
  opts = function()
    local custom_keymaps = {
      { 'n', 'q', '<cmd>DiffviewClose<CR>', { desc = 'Close Diffview' } },
      {
        'n',
        '<leader>ga',
        function()
          require('diffview.actions').toggle_stage_entry()
        end,
        { desc = 'Git Add: Toggle Stage file' },
      },
      {
        'n',
        '<leader>gS',
        function()
          require('diffview.actions').stage_all()
        end,
        { desc = 'Stage all' },
      },
      {
        'n',
        '<leader>gU',
        function()
          require('diffview.actions').unstage_all()
        end,
        { desc = 'Unstage all' },
      },
      {
        'n',
        '<leader>gc',
        function()
          local commit_message = vim.fn.input({ prompt = 'Commit message: ', default = nil })
          if commit_message then
            local command = string.format('!git commit -m "%s"', commit_message)
            vim.cmd(command)
          end
        end,
        { desc = 'Commit' },
      },
      {
        'n',
        '<leader>gP',
        function()
          vim.cmd('!git push')
        end,
        { desc = 'Push' },
      },
    }
    return {
      enhanced_diff_hl = true,
      view = {
        default = {
          layout = 'diff2_vertical',
          winbar_info = true,
        },
        merge_tool = {
          layout = 'diff3_mixed',
        },
      },
      keymaps = {
        view = custom_keymaps,
        file_panel = custom_keymaps,
      },
    }
  end,
}

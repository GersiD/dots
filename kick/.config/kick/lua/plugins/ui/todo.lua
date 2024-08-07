return {
  'folke/todo-comments.nvim',
  cmd = { 'TodoTrouble', 'TodoTelescope' },
  event = 'VeryLazy',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {},
      -- stylua: ignore
      keys = {
              { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
              { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
              { "<leader>xx", "<cmd>TodoQuickFix<cr>",                             desc = "Todo (Trouble)" },
              { "<leader>xX", "<cmd>TodoQuickFix keywords=TODO,FIX,FIXME<cr>",     desc = "Todo/Fix/Fixme (Trouble)" },
              { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
              { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "Todo/Fix/Fixme" },
      },
}

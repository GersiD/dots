return {
  "cbochs/grapple.nvim",
  cmd = "GrapplePopup",
  keys = {
    { "<leader>hh", "<cmd>GrapplePopup tags<cr>", mode = { "n" }, desc = "Harpoon 🐳" },
    {
      "<leader>ha",
      function()
        require("grapple").toggle()
      end,
      mode = { "n" },
      desc = "Harpoon Toggle File 🐳",
    },
  },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("grapple").setup({
      scope = require("grapple").resolvers.directory,
      popup_options = {
        relative = "editor",
        width = 60,
        height = 12,
        style = "minimal",
        border = "rounded",
      },
    })
  end,
}

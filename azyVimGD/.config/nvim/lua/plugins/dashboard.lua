return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  opts = function(_, opts)
    local center = {
      {
        action = "Telescope find_files",
        desc = " Find file",
        icon = " ",
        key = "f",
      },
      {
        action = 'lua require("config.utils.terminals").run("lazygit")',
        desc = " Open lazygit",
        icon = " ",
        key = "g",
      },
      {
        action = "Telescope oldfiles",
        desc = " Recent files",
        icon = " ",
        key = "r",
      },
      {
        action = [[lua require("lazyvim.util").telescope.config_files()()]],
        desc = " Config",
        icon = " ",
        key = "c",
      },
      {
        action = 'lua require("persistence").load()',
        desc = " Restore Session",
        icon = " ",
        key = "s",
      },
      {
        action = "Lazy",
        desc = " Lazy",
        icon = "󰒲 ",
        key = "l",
      },
    }
    -- replace default center section with custom section
    opts.config.center = center
  end,
}

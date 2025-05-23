-- Themes
return {
  {
    'sainnhe/everforest',
    config = function()
      -- Available values: 'hard', 'medium'(default), 'soft'
      vim.g.everforest_background = 'hard'
      vim.g.everforest_better_performance = 1
      vim.g.everforest_ui_contrast = 'high'
    end,
  },
  {
    'sainnhe/gruvbox-material',
    config = function()
      vim.g.gruvbox_material_enable_italic = false
      ---@usage 'original'|'mix'|'material'
      vim.g.gruvbox_material_foreground = 'original'
      ---@usage 'hard'|'medium'|'soft'
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_better_performance = 1
      ---@usage 'grey', 'red', 'orange', 'yellow', 'green', 'aqua', 'blue', 'purple'
      vim.g.gruvbox_material_menu_selection_background = 'grey'
    end,
  },
  {
    'folke/tokyonight.nvim',
    ---@class tokyonight.Config
    ---@field on_colors fun(colors: ColorScheme)
    ---@field on_highlights fun(highlights: tokyonight.Highlights, colors: ColorScheme)
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      style = 'moon', -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
      -- no_italic = true, -- Disable italic comments, keywords, etc.
      transparent = false, -- Enable transparent background
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        -- comments = { italic = true },
        keywords = { italic = false },
        functions = { italic = false },
        variables = { italic = false },
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = 'normal', -- style for sidebars, see below
        floats = 'normal', -- style for floating windows
      },
      cache = true,
      sidebars = { 'qf', 'help' }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
      -- day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
      -- hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.

      --- You can override specific color groups to use other groups or a hex color
      --- function will be called with a ColorScheme table
      ---@param colors ColorScheme
      -- on_colors = function(colors) end,

      --- You can override specific highlights to use other groups or a hex color
      --- function will be called with a Highlights and ColorScheme table
      ---@param highlights Highlights
      ---@param colors ColorScheme
      -- on_highlights = function(highlights, colors) end,
    },
  },
  {
    'tiagovla/tokyodark.nvim',
    opts = {
      -- custom options here
      styles = {
        comments = { italic = false }, -- style for comments
        keywords = { italic = false }, -- style for keywords
        identifiers = { italic = false }, -- style for identifiers
        functions = {}, -- style for functions
        variables = {}, -- style for variables
      },
    },
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
      require('catppuccin').setup({
        flavour = 'macchiato',
        no_italic = true,
        integrations = {
          alpha = true,
          cmp = true,
          blink_cmp = true,
          dashboard = true,
          grug_far = true,
          gitsigns = true,
          headlines = true,
          illuminate = true,
          indent_blankline = { enabled = true },
          lsp_trouble = true,
          mason = true,
          markdown = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { 'undercurl' },
              hints = { 'undercurl' },
              warnings = { 'undercurl' },
              information = { 'undercurl' },
            },
          },
          navic = { enabled = true, custom_bg = 'lualine' },
          neotest = true,
          noice = true,
          semantic_tokens = true,
          snacks = true,
          treesitter = true,
          treesitter_context = true,
          notify = true,
          mini = true,
          leap = true,
          aerial = true,
          telescope = true,
          fidget = true,
          flash = true,
          neotree = true,
          which_key = true,
          -- For more plugins integrations see (https://github.com/catppuccin/nvim#integrations)
        },
      })
    end,
  },
  {
    'ribru17/bamboo.nvim',
    opts = { -- Main options --
      ---@usage 'vulgaris'|'multiplex'
      style = 'vulgaris',
      -- Custom Highlights --
      -- colors = {}, -- Override default colors
      highlights = {
        MiniIndentscopeSymbol = { fg = '$light_grey' },
      }, -- Override highlight groups

      -- Plugins Config --
      diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true, -- use undercurl instead of underline for diagnostics
        background = true, -- use background color for virtual text
      },
      -- transparent = false, -- Show/hide background
      -- term_colors = true, -- Change terminal color as per the selected theme style
      -- ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
      -- cmp_itemkind_reverse = true, -- reverse item kind highlights in cmp menu

      -- Change code style ---
      -- Options are italic, bold, underline, none
      -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
      code_style = {
        comments = 'none',
        conditionals = 'none',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none',
      },
    },
  },
  {
    'Zeioth/neon.nvim',
    opts = {
      dim_inactive = false,
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
      },
    },
  },
  -- {
  --   'rebelot/kanagawa.nvim',
  --   opts = {
  --     compile = false, -- enable compiling the colorscheme
  --     undercurl = true, -- enable undercurls
  --     commentStyle = { italic = false },
  --     functionStyle = { italic = false },
  --     keywordStyle = { italic = false },
  --     statementStyle = { italic = false },
  --     typeStyle = { italic = false },
  --     variableStyle = { italic = false },
  --     transparent = false, -- do not set background color
  --     dimInactive = false, -- dim inactive window `:h hl-NormalNC`
  --     terminalColors = true, -- define vim.g.terminal_color_{0,17}
  --     colors = { -- add/modify theme and palette colors
  --       palette = {},
  --       theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
  --     },
  --     theme = 'dragon', -- Load "wave" theme when 'background' option is not set
  --     background = { -- map the value of 'background' option to a theme
  --       dark = 'wave', -- try "dragon" !
  --       light = 'lotus',
  --     },
  --   },
  -- },
}

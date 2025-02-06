return {
  'saghen/blink.cmp',
  build = 'cargo build --release',
  dependencies = {
    -- add blink.compat to dependencies
    -- allows you to use nvim-cmp sources with blink.cmp
    -- {
    -- 'saghen/blink.compat',
    -- opts = {},
    -- },
    'L3MON4D3/LuaSnip',
    'mikavilpas/blink-ripgrep.nvim',
  },
  event = 'InsertEnter',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    snippets = {
      expand = function(snippet)
        require('luasnip').lsp_expand(snippet)
      end,
      active = function(filter)
        if filter and filter.direction then
          return require('luasnip').jumpable(filter.direction)
        end
        return require('luasnip').in_snippet()
      end,
      jump = function(direction)
        require('luasnip').jump(direction)
      end,
    },
    appearance = {
      -- sets the fallback highlight groups to nvim-cmp's highlight groups
      -- useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release, assuming themes add support
      use_nvim_cmp_as_default = true,
      -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'normal',
      kind_icons = require('config.icons').kinds,
    },
    completion = {
      trigger = {
        -- When true, will prefetch the completion items when entering insert mode
        -- WARN: buggy, not recommended unless you'd like to help develop prefetching
        prefetch_on_insert = true, -- this is now default but good idea to keep here in case
      },
      accept = {
        -- experimental auto-brackets support
        auto_brackets = {
          enabled = true,
        },
      },
      menu = {
        draw = {
          -- treesitter = { 'lsp' },
          columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind' } },
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                local kind_icon = require('config.icons').kinds[ctx.kind]
                return kind_icon
              end,
              -- Optionally, you may also use the highlights from mini.icons
              -- highlight = function(ctx)
              --   local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
              --   return hl
              -- end,
            },
          },
        },
        border = 'rounded',
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = 'rounded',
        },
      },
      ghost_text = {
        enabled = false,
      },
      list = {
        selection = {
          preselect = function(ctx)
            if ctx.mode == 'cmdline' then
              return false
            end
            return true
          end,
          auto_insert = false,
        },
      },
    },
    -- experimental signature help support
    signature = { enabled = true },
    sources = {
      -- adding any nvim-cmp sources here will enable them
      -- with blink.compat
      -- compat = {},
      default = { 'lsp', 'snippets', 'path', 'ripgrep' },
      -- cmdline = {}, -- This disables it
      providers = {
        ripgrep = {
          module = 'blink-ripgrep',
          name = 'Ripgrep',
          -- the options below are optional, some default values are shown
          ---@module "blink-ripgrep"
          ---@type blink-ripgrep.Options
          opts = {
            -- For many options, see `rg --help` for an exact description of
            -- the values that ripgrep expects.

            -- the minimum length of the current word to start searching
            -- (if the word is shorter than this, the search will not start)
            prefix_min_len = 3,

            -- The number of lines to show around each match in the preview
            -- (documentation) window. For example, 5 means to show 5 lines
            -- before, then the match, and another 5 lines after the match.
            context_size = 5,

            -- The maximum file size of a file that ripgrep should include in
            -- its search. Useful when your project contains large files that
            -- might cause performance issues.
            -- Examples:
            -- "1024" (bytes by default), "200K", "1M", "1G", which will
            -- exclude files larger than that size.
            max_filesize = '1M',

            -- Specifies how to find the root of the project where the ripgrep
            -- search will start from. Accepts the same options as the marker
            -- given to `:h vim.fs.root()` which offers many possibilities for
            -- configuration. If none can be found, defaults to Neovim's cwd.
            --
            -- Examples:
            -- - ".git" (default)
            -- - { ".git", "package.json", ".root" }
            project_root_marker = '.git',

            -- Enable fallback to neovim cwd if project_root_marker is not
            -- found. Default: `true`, which means to use the cwd.
            project_root_fallback = true,

            -- The casing to use for the search in a format that ripgrep
            -- accepts. Defaults to "--ignore-case". See `rg --help` for all the
            -- available options ripgrep supports, but you can try
            -- "--case-sensitive" or "--smart-case".
            search_casing = '--ignore-case',

            -- (advanced) Any additional options you want to give to ripgrep.
            -- See `rg -h` for a list of all available options. Might be
            -- helpful in adjusting performance in specific situations.
            -- If you have an idea for a default, please open an issue!
            --
            -- Not everything will work (obviously).
            additional_rg_options = {},

            -- When a result is found for a file whose filetype does not have a
            -- treesitter parser installed, fall back to regex based highlighting
            -- that is bundled in Neovim.
            fallback_to_regex_highlighting = true,

            -- Absolute root paths where the rg command will not be executed.
            -- Usually you want to exclude paths using gitignore files or
            -- ripgrep specific ignore files, but this can be used to only
            -- ignore the paths in blink-ripgrep.nvim, maintaining the ability
            -- to use ripgrep for those paths on the command line. If you need
            -- to find out where the searches are executed, enable `debug` and
            -- look at `:messages`.
            ignore_paths = {},

            -- Any additional paths to search in, in addition to the project
            -- root. This can be useful if you want to include dictionary files
            -- (/usr/share/dict/words), framework documentation, or any other
            -- reference material that is not available within the project
            -- root.
            additional_paths = {},

            -- Show debug information in `:messages` that can help in
            -- diagnosing issues with the plugin.
            debug = false,
          },
          -- (optional) customize how the results are displayed. Many options
          -- are available - make sure your lua LSP is set up so you get
          -- autocompletion help
          transform_items = function(_, items)
            for _, item in ipairs(items) do
              -- example: append a description to easily distinguish rg results
              item.labelDetails = {
                description = '*rg*',
              }
            end
            return items
          end,
        },
      },
    },
    keymap = {
      preset = 'enter',
      ['<C-Space>'] = { 'show' },
      ['<Tab>'] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.snippet_forward()
          else
            return cmp.select_and_accept()
          end
        end,
        'snippet_forward',
        'fallback',
      },
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
      ['<C-j>'] = { 'select_next' },
      ['<C-k>'] = { 'select_prev' },
      ['<C-d>'] = { 'scroll_documentation_down' },
      ['<C-f>'] = { 'scroll_documentation_up' },
      ['<C-g>'] = {
        function()
          -- invoke manually, requires blink >v0.8.0
          require('blink-cmp').show({ providers = { 'ripgrep' } })
        end,
      },
    },
  },
  ---@param opts blink.cmp.Config | { sources: { compat: string[] } }
  -- config = function(_, opts)
  -- end,
}

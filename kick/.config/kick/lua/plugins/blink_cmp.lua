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
      nerd_font_variant = 'mono',
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
          -- columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind' } },
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
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
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
      default = { 'lsp', 'snippets', 'path', 'buffer' },
      -- cmdline = {}, -- This disables it
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
    },
  },
  ---@param opts blink.cmp.Config | { sources: { compat: string[] } }
  -- config = function(_, opts)
  -- end,
}

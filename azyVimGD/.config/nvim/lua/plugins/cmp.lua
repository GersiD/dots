return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-nvim-lsp-signature-help",
  },
  event = "VimEnter",
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local cmp = require("cmp")
    opts.completion.completeopt = "menu,menuone,preview,longest"
    opts.window = {
      completion = cmp.config.window.bordered({}),
      documentation = cmp.config.window.bordered({}),
    }
    opts.mapping = cmp.mapping.preset.insert({
      ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    })
    -- Only use buffer source if LSP is not available (e.g. inside a string context)
    opts.sources = cmp.config.sources({
      { name = "nvim_lsp", priority = 100 },
      { name = "luasnip", priority = 90 },
      { name = "path" },
      { name = "emoji" },
    }, {
      { name = "buffer" },
    })
    opts.formatting = {
      fields = { "kind", "abbr", "menu" },
      -- fields = { "abbr", "menu", "kind" },
      expandable_indicator = false,
      -- fields = { "abbr", "kind", "menu" },
      format = function(_, item)
        local icons = require("lazyvim.config").icons.kinds
        if icons[item.kind] then
          item.menu = item.kind
          -- item.menu = "" -- incase you want it more minimal
          item.kind = icons[item.kind] .. " │"
        end
        return item
      end,
    }
    opts.experimental = {
      ghost_text = false,
    }
    local other_mappings = cmp.mapping.preset.cmdline({
      ["<C-j>"] = {
        c = function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
          else
            fallback()
          end
        end,
      },
      ["<C-k>"] = {
        c = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end,
      },
      ["<CR>"] = {
        c = function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true })
          else
            fallback()
          end
        end,
      },
    })
    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    ---@diagnostic disable-next-line: missing-fields
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = other_mappings,
      sources = {
        { name = "buffer" },
      },
    })
    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    ---@diagnostic disable-next-line: missing-fields
    cmp.setup.cmdline(":", {
      mapping = other_mappings,
      sources = cmp.config.sources({
        { name = "cmdline" },
      }),
    })
  end,
}

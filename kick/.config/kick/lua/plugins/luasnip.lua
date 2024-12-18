return {
  'L3MON4D3/LuaSnip',
  lazy = true,
  dependencies = {
    {
      'rafamadriz/friendly-snippets',
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
        vim.notify('Loading the snips bro ' .. vim.fn.stdpath('config') .. '/snippets', vim.log.levels.INFO, {})
        require('luasnip.loaders.from_vscode').lazy_load({ paths = { vim.fn.stdpath('config') .. '/snippets' } })
      end,
    },
  },
  opts = function()
    local types = require('luasnip.util.types')
    return {
      ext_opts = {
        [types.insertNode] = {
          unvisited = {
            virt_text = { { '|', 'Conceal' } },
            virt_text_pos = 'inline',
          },
        },
        -- This is needed because LuaSnip differentiates between $0 and other
        -- placeholders (exitNode and insertNode). So this will highlight the last
        -- jump node.
        [types.exitNode] = {
          unvisited = {
            virt_text = { { '|', 'Conceal' } },
            virt_text_pos = 'inline',
          },
        },
      },
    }
  end,
}

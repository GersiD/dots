return {
  'L3MON4D3/LuaSnip',
  lazy = true,
  dependencies = {
    -- From now on I want to use my own snippets
    -- {
    --   'rafamadriz/friendly-snippets',
    --   config = function()
    --     require('luasnip.loaders.from_vscode').lazy_load()
    --     require('luasnip.loaders.from_vscode').lazy_load({ paths = { vim.fn.stdpath('config') .. '/snippets' } })
    --   end,
    -- },
  },
  opts = function()
    local types = require('luasnip.util.types')
    return {
      -- only `//` in tex math; everything else expands from the completion menu
      enable_autosnippets = true,
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
  config = function(_, opts)
    local ls = require('luasnip')
    ls.setup(opts)
    -- Lua rather than VS Code JSON so snippets can carry conditions (e.g. tex math-only)
    require('luasnip.loaders.from_lua').lazy_load({ paths = { vim.fn.stdpath('config') .. '/luasnippets' } })

    -- leaving insert/select for normal mode ends the snippet, so re-entering insert later doesn't
    -- resume old jump points; jump_active skips the mode changes LuaSnip makes while jumping
    vim.api.nvim_create_autocmd('ModeChanged', {
      group = vim.api.nvim_create_augroup('luasnip-unlink-on-normal', { clear = true }),
      pattern = '[is]:n',
      callback = function()
        -- unlink_current() only drops the innermost snippet, so repeat for nested ones
        while ls.session.current_nodes[vim.api.nvim_get_current_buf()] and not ls.session.jump_active do
          ls.unlink_current()
        end
      end,
    })
  end,
}

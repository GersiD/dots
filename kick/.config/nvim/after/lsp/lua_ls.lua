---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false,
      },
      -- stylua formats Lua through conform
      format = {
        enable = false,
      },
      completion = {
        callSnippet = 'Replace',
      },
    },
  },
}

---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false,
      },
      format = {
        enable = true,
      },
      completion = {
        callSnippet = 'Replace',
      },
    },
  },
}

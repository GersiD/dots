---@type vim.lsp.ClientConfig
return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  single_file_support = true,
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },
  log_level = vim.lsp.protocol.MessageType.Warning,
  settings = {
    workspace = {
      checkThirdParty = false,
    },
    -- → Lua.format.enable                   default: true
    format = {
      enable = false,
    },
    completion = {
      callSnippet = 'Replace',
    },
  },
}

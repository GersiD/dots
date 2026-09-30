-- clangd server settings live in after/lsp/clangd.lua
return {
  -- provides :ClangdSwitchSourceHeader for ftplugin/cpp.lua
  'p00f/clangd_extensions.nvim',
  ft = { 'c', 'cpp' },
}

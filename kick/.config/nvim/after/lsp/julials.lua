-- Only the keys LanguageServer.jl requests are read: julia.lint.*, julia.completionmode,
-- julia.inlayHints.static.* (see request_julia_config in its src/requests/workspace.jl)
---@type vim.lsp.Config
return {
  settings = {
    julia = {
      lint = {
        -- unresolved-name warnings are mostly false positives from macros and unindexed packages
        missingrefs = 'none',
        -- replaces the server default rather than extending it, so keep test/docs listed
        disabledDirs = { 'test', 'docs' },
      },
    },
  },
}

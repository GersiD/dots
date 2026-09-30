---@type vim.lsp.Config
return {
  skip_inlay = true,
  settings = {
    texlab = {
      build = {
        args = {},
        executable = '',
        forwardSearchAfter = false,
        onSave = false,
      },
      inlayHints = {
        labelReferences = false,
        labelDefinitions = false,
      },
      chktex = {
        onEdit = false, -- default value
        onOpenAndSave = false,
      },
      latexindent = {
        modifyLineBreaks = false,
      },
      -- formatterLineLength = 10, -- doesnt work aparently
    },
  },
}

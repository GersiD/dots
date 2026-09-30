---@type vim.lsp.Config
return {
  settings = {
    julia = {
      NumThreads = 4,
      execution = {
        codeInREPL = true,
      },
      format = {
        -- comments = false,
        indents = 10,
      },
    },
    -- settings wintout julia
    NumThreads = 4,
    execution = {
      codeInREPL = true,
    },
    format = {
      -- comments = false,
      indents = 10,
    },
  },
}

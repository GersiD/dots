---@type vim.lsp.Config
return {
  --TODO Figure out which works
  -- settings with julia
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
  -- no settings with julia
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
  -- no settings without julia
  NumThreads = 4,
  execution = {
    codeInREPL = true,
  },
  format = {
    -- comments = false,
    indents = 10,
  },
}

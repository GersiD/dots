---@type vim.lsp.Config
return {
  settings = {
    ltex = {
      checkFrequency = 'save',
      language = 'en-US',
      diagnosticSeverity = 'hint',
      completionEnabled = true,
      dictionary = {
        ['en-US'] = {
          'Gersi',
          'Doko',
          'CVaR',
          'Palash',
          'Petrik',
          'VaR',
          'CVaR',
          'Neovim',
          'Zettelkasten',
          'LPAL',
          'EVaR',
          'monotonicity',
          'functionals',
          'supremum',
          'Expectile',
          'OCE',
          'Monkie',
          'TVaR',
        },
      },
    },
  },
}

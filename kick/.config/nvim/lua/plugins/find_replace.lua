return {
  'MagicDuck/grug-far.nvim',
  ---@type GrugFarOptions
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    headerMaxWidth = 80,
    visualSelectionUsage = 'operate-within-range',
    ---@diagnostic disable-next-line: missing-fields
    keymaps = {
      previewLocation = { n = '<localleader>i' },
      applyNext = { n = '<C-j>' },
      applyPrev = { n = '<C-k>' },
      close = { n = 'q' },
      replace = { n = '<leader>r' },
      qflist = { n = '<C-q>' },
      syncLocations = { n = '<C-s>' },
      syncLine = { n = '<C-CR>' },
      openLocation = { n = '<localleader>o' },
      openNextLocation = { n = '<down>' },
      openPrevLocation = { n = '<up>' },
      gotoLocation = { n = '<enter>' },
      abort = { n = '<C-c>' },
      pickHistoryEntry = { n = '<enter>' },
      help = { n = 'g?' },
      toggleShowCommand = { n = '<localleader>p' },
      swapEngine = { n = '<localleader>e' },
      swapReplacementInterpreter = { n = '<localleader>x' },
      historyOpen = { n = '<localleader>t' },
      historyAdd = { n = '<localleader>a' },
      refresh = { n = '<localleader>r' },
    },
  },
  cmd = 'GrugFar',
  keys = {
    {
      '<leader>fr',
      function()
        local grug = require('grug-far')
        local ext = vim.bo.buftype == '' and vim.fn.expand('%:e')
        grug.open({
          transient = true,
          prefills = {
            filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
          },
        })
      end,
      mode = { 'n', 'v' },
      desc = 'Search and Replace',
    },
  },
}

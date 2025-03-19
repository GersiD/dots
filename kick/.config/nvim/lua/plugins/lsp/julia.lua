return {
  'klafyvel/nvim-smuggler',
  ft = { 'julia' },
  opts = function()
    return {
      ui = {
        mappings = { -- set to false to disable all mappings.
          smuggle = '<C-CR>', -- Mapping for Smuggle in normal mode.
          smuggle_range = '\\s', -- For SmuggleRange in visual mode.
          smuggle_config = '<leader>ce', -- SmuggleConfig in normal mode.
          smuggle_operator = 'gcs', -- SmuggleOperator in normal mode.
        },
        evaluated_hl = 'MoreMsg', -- highlight group for evaluated chunks.
        invalidated_hl = 'WarningMsg', -- highlight group for invalidated evaluated chunks.
        result_line_length = 80, -- line length of displayed results.
        result_hl_group = 'DiagnosticVirtualTextInfo', -- highlight group used for results.
        display_results = true, -- Display evaluation results.
        display_images = true, -- Display images if `images.nvim` is present.
        images_height = 10, -- Number of lines an image should occupy.
        eval_sign_text = '│', -- Symbol in signcolumn to mark evaluated/invalidated , set to "" to disable
        show_eval = true, -- If set to false, do not attempt to track modifications in evaluated code chunks.
        qf_skip_base = false, -- If true, do not show errors in `Base`.
        qf_auto_refresh = false, -- If true, the quickfix list is refreshed each time an error is smuggled.
        qf_auto_open = false, -- If true, the quickfix window is opened each time nvim-smuggler refreshes the quickfix window.
        qf_custom_text = false, -- If true, the quickfix text will be altered to look like Julia REPL Exception printing.
        qf_custom_display = false, -- If true, the quickfix window will be given an opinionated look (works with qf_custom_text).
      },
      log = {
        level = 'warn', -- available: trace, debug, info, warn, error, fatal
        use_file = false, -- output logs to `stdpath("data")/smuggler.log`, e.g. `~/.local/share/nvim/smuggler.log `
        use_console = true, -- output logs to the console.
      },
      buffers = {
        eval_by_blocks = false, -- Configure each new session eval by block attribute.
        autoselect_single_socket = true, -- When true, skip socket selection
        -- dialog if there's only one choice possible.
        showdir = vim.fs.dirname(vim.fn.tempname()),
        -- either a string, a table of string, or a function that returns one
        -- of the former. This is a list of sockets for nvim-smuggler to try to
        -- connect to.
        availablesockets = require('smuggler.utils').getavailablesockets,
        iocontext = { -- Julia's IOContext
          -- (https://docs.julialang.org/en/v1/base/io-network/#Base.IOContext-Tuple%7BIO,%20Pair%7D)
          -- options to use.
          compact = true,
          limit = true,
          displaysize = { 10, 80 },
        },
      },
    }
  end,
  dependencies = { 'nvim-neotest/nvim-nio' },
}

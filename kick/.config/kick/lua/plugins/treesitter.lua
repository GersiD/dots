return {
  'nvim-treesitter/nvim-treesitter',
  version = false, -- last release is way too old and doesn't work on Windows
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  event = 'VeryLazy',
  cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
  keys = {
    { '<c-\\>', desc = 'Increment selection' },
    { '<bs>', desc = 'Decrement selection', mode = 'x' },
  },

  ---@type TSConfig
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    highlight = {
      enable = true,
      disable = { 'tex' },
    },
    indent = { enable = true },
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = {
      'markdown',
      'c',
      'cpp',
      'go',
      'lua',
      'python',
      'ninja',
      'toml',
      'jsonc',
      'rst',
      'rust',
      'tsx',
      'javascript',
      'typescript',
      'vimdoc',
      'vim',
      'hyprlang',
    },
    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = true,
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-\\>',
        node_incremental = '<c-\\>',
        scope_incremental = false,
        node_decremental = '<bs>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  },
  config = function()
    vim.cmd('TSEnable highlight') -- WARN: This is not ideal, but it's the only way to force enable treesitter highlighting
  end,
}

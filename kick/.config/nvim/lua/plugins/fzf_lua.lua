---@module "lazy"
---@type LazySpec
return {
  'ibhagwan/fzf-lua',
  cmd = 'FzfLua',
  dependencies = { 'echasnovski/mini.icons' },

  init = function()
    vim.ui.select = function(...)
      require('lazy').load({ plugins = { 'fzf-lua' } })
      local ui_select = function(fzf_opts, items)
        return vim.tbl_deep_extend('force', fzf_opts, {
          prompt = ' ',
          winopts = {
            title = ' ' .. vim.trim((fzf_opts.prompt or 'Select'):gsub('%s*:%s*$', '')) .. ' ',
            title_pos = 'center',
          },
        }, fzf_opts.kind == 'codeaction' and {
          winopts = {
            layout = 'vertical',
            -- height is number of items minus 15 lines for the preview, max 80% screen height
            height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 2) + 0.5) + 16,
            width = 0.5,
            preview = not vim.tbl_isempty(vim.lsp.get_clients({ bufnr = 0, name = 'vtsls' })) and {
              layout = 'vertical',
              vertical = 'down:15,border-top',
              hidden = 'hidden',
            } or {
              layout = 'vertical',
              vertical = 'down:15,border-top',
            },
          },
        } or {
          winopts = {
            width = 0.5,
            height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
          },
        })
      end
      require('fzf-lua').register_ui_select(ui_select)
      return vim.ui.select(...)
    end
  end,

  opts = function()
    local config = require('fzf-lua.config')
    local actions = require('fzf-lua.actions')

    config.defaults.keymap.fzf['ctrl-q'] = 'select-all+accept'
    config.defaults.keymap.fzf['ctrl-u'] = 'half-page-up'
    config.defaults.keymap.fzf['ctrl-d'] = 'half-page-down'
    config.defaults.keymap.fzf['ctrl-x'] = 'jump'
    config.defaults.keymap.fzf['ctrl-f'] = 'preview-page-down'
    config.defaults.keymap.fzf['ctrl-b'] = 'preview-page-up'
    config.defaults.keymap.builtin['<c-f>'] = 'preview-page-down'
    config.defaults.keymap.builtin['<c-b>'] = 'preview-page-up'

    -- was unconditional; errors at startup if trouble isn't loaded
    local ok_trouble, trouble_fzf = pcall(require, 'trouble.sources.fzf')
    if ok_trouble then
      config.defaults.actions.files['ctrl-t'] = trouble_fzf.actions.open
    end

    -- ported from telescope <c-c>: copy entry to clipboard.
    -- NOT bound to ctrl-c here: fzf reserves that for abort.
    config.defaults.actions.files['ctrl-y'] = function(selected)
      local value = selected[1]
      vim.fn.setreg('+', value)
      vim.notify(value, nil, { title = 'Copied', icon = '󰅍' })
    end

    local img_previewer ---@type string[]?
    for _, v in ipairs({
      { cmd = 'ueberzug', args = {} },
      { cmd = 'chafa',    args = { '{file}', '--format=symbols' } },
      { cmd = 'viu',      args = { '-b' } },
    }) do
      if vim.fn.executable(v.cmd) == 1 then
        img_previewer = vim.list_extend({ v.cmd }, v.args)
        break
      end
    end

    return {
      'default-title',
      fzf_colors = {
        ['fg'] = { 'fg', 'CursorLine' },
        ['bg'] = { 'bg', 'Normal' },
        ['hl'] = { 'fg', 'Comment' },
        ['fg+'] = { 'fg', 'Normal' },
        ['bg+'] = { 'bg', 'CursorLine' },
        ['hl+'] = { 'fg', 'Statement' },
        ['info'] = { 'fg', 'PreProc' },
        ['prompt'] = { 'fg', 'Conditional' },
        ['pointer'] = { 'fg', 'Exception' },
        ['marker'] = { 'fg', 'Keyword' },
        ['spinner'] = { 'fg', 'Label' },
        ['header'] = { 'fg', 'Comment' },
      },
      fzf_opts = { ['--no-scrollbar'] = true },

      defaults = {
        formatter = 'path.dirname_first',
      },

      winopts = {
        width = 0.8,
        height = 0.8,
        row = 0.5,
        col = 0.5,
        preview = {
          scrollchars = { '┃', '' },
        },
      },

      previewers = {
        builtin = {
          extensions = {
            ['png']  = img_previewer,
            ['jpg']  = img_previewer,
            ['jpeg'] = img_previewer,
            ['gif']  = img_previewer,
            ['webp'] = img_previewer,
          },
          ueberzug_scaler = 'fit_contain',
        },
      },

      files = {
        cwd_prompt = false,
        cmd = 'rg --no-config --files --sortr=modified',
        fzf_opts = {
          ['--scheme'] = 'default',
          ['--tiebreak'] = 'begin',
        },
        actions = {
          ['alt-i'] = { actions.toggle_ignore },
          ['alt-h'] = { actions.toggle_hidden },
        },
      },

      -- --tiebreak=index keeps equal-scoring lines in buffer order
      blines = {
        fzf_opts = { ['--tiebreak'] = 'index' },
      },

      grep = {
        actions = {
          ['alt-i'] = { actions.toggle_ignore },
          ['alt-h'] = { actions.toggle_hidden },
        },
      },

      lsp = {
        -- ported from telescope pickers.lsp_references
        includeDeclaration = false,
        symbols = {
          symbol_hl = function(s)
            return 'TroubleIcon' .. s
          end,
          symbol_fmt = function(s)
            return s:lower() .. '\t'
          end,
          child_prefix = false,
        },
        code_actions = {
          previewer = vim.fn.executable('delta') == 1 and 'codeaction_native' or nil,
        },
      },
    }
  end,

  config = function(_, opts)
    if opts[1] == 'default-title' then
      local function fix(t)
        t.prompt = t.prompt ~= nil and ' ' or nil
        for _, v in pairs(t) do
          if type(v) == 'table' then
            fix(v)
          end
        end
        return t
      end
      opts = vim.tbl_deep_extend('force', fix(require('fzf-lua.profiles.default-title')), opts)
      opts[1] = nil
    end
    require('fzf-lua').setup(opts)
  end,

  keys = {
    { '<c-j>', '<c-j>', ft = 'fzf', mode = 't', nowait = true },
    { '<c-k>', '<c-k>', ft = 'fzf', mode = 't', nowait = true },

    -- ======================= ported from telescope =======================
    {
      '<C-f>',
      function()
        require('fzf-lua').blines({
          winopts = {
            width = 0.7,
            height = 0.4,
            preview = { hidden = true },
            backdrop = 80,
            treesitter = {
              enabled = false,
            }
          },
        })
      end,
      desc = 'Find in buffer',
    },
    {
      '<leader>ff',
      function()
        require('fzf-lua').files()
      end,
      desc = 'Find files',
    },
    {
      '<leader>fa',
      function()
        require('fzf-lua').files({ hidden = true, no_ignore = true })
      end,
      desc = 'Find all files',
    },
    {
      '<leader>fw',
      function()
        require('fzf-lua').live_grep({ hidden = true, no_ignore = true })
      end,
      desc = 'Find words',
    },
    {
      '<leader>gf',
      function()
        require('fzf-lua').git_files()
      end,
      desc = 'Find git files',
    },
    {
      '<leader>fd',
      function()
        require('fzf-lua').diagnostics_document()
      end,
      desc = 'Search diagnostics',
    },
    {
      '<leader>fm',
      function()
        require('fzf-lua').man_pages()
      end,
      desc = 'Find Man Pages',
    },
    {
      '<leader>fh',
      function()
        -- telescope version mapped <CR> to select_vertical
        require('fzf-lua').help_tags({
          actions = { ['enter'] = actions.help_vert },
        })
      end,
      desc = 'Find Help',
    },
    {
      '<leader>bf',
      function()
        -- ctrl-x is fzf-lua's built-in buffer delete (was `dd` in telescope)
        require('fzf-lua').buffers({ sort_lastused = true, sort_mru = true })
      end,
      desc = 'Find Buffers',
    },
    {
      '<leader>ft',
      function()
        local themes = require('plugins.ui.themes')
        for _, theme in ipairs(themes) do
          local name = theme.name and theme.name or string.match(theme[1], '([^/]+)$')
          require('lazy').load({ plugins = name })
        end
        require('fzf-lua').colorschemes({
          winopts = { width = 0.35, height = 0.4 },
        })
      end,
      desc = 'Find themes',
    },
    { '<leader>fk', '<cmd>FzfLua keymaps<cr>',                                  desc = 'Find Keymaps' },
    { '<leader>fH', '<cmd>FzfLua highlights<cr>',                               desc = 'Find Highlights' },
    { '<leader>r',  '<cmd>FzfLua commands<cr>',                                 desc = 'Find Commands' },
    -- NOTE: <leader>fv (telescope vim_options) has no fzf-lua equivalent. See notes.

    -- ======================= already in fzf-lua config =======================
    { '<leader>,',  '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>', desc = 'Switch Buffer' },
    { '<leader>:',  '<cmd>FzfLua command_history<cr>',                          desc = 'Command History' },
    { '<leader>fF', '<cmd>FzfLua files<cr>',                                    desc = 'Find Files (cwd)' },
    { '<leader>fg', '<cmd>FzfLua git_files<cr>',                                desc = 'Find Files (git-files)' },
    { '<leader>fr', '<cmd>FzfLua oldfiles<cr>',                                 desc = 'Recent' },
    {
      '<leader>fR',
      function()
        require('fzf-lua').oldfiles({ cwd = vim.uv.cwd() })
      end,
      desc = 'Recent (cwd)',
    },
    { '<leader>gc', '<cmd>FzfLua git_commits<cr>',           desc = 'Commits' },
    { '<leader>gs', '<cmd>FzfLua git_status<cr>',            desc = 'Status' },
    { '<leader>s"', '<cmd>FzfLua registers<cr>',             desc = 'Registers' },
    { '<leader>sa', '<cmd>FzfLua autocmds<cr>',              desc = 'Auto Commands' },
    { '<leader>sb', '<cmd>FzfLua grep_curbuf<cr>',           desc = 'Buffer' },
    { '<leader>sc', '<cmd>FzfLua command_history<cr>',       desc = 'Command History' },
    { '<leader>sC', '<cmd>FzfLua commands<cr>',              desc = 'Commands' },
    { '<leader>sd', '<cmd>FzfLua diagnostics_document<cr>',  desc = 'Document Diagnostics' },
    { '<leader>sD', '<cmd>FzfLua diagnostics_workspace<cr>', desc = 'Workspace Diagnostics' },
    { '<leader>sh', '<cmd>FzfLua help_tags<cr>',             desc = 'Help Pages' },
    { '<leader>sH', '<cmd>FzfLua highlights<cr>',            desc = 'Search Highlight Groups' },
    { '<leader>sj', '<cmd>FzfLua jumps<cr>',                 desc = 'Jumplist' },
    { '<leader>sk', '<cmd>FzfLua keymaps<cr>',               desc = 'Key Maps' },
    { '<leader>sl', '<cmd>FzfLua loclist<cr>',               desc = 'Location List' },
    { '<leader>sM', '<cmd>FzfLua man_pages<cr>',             desc = 'Man Pages' },
    { '<leader>sm', '<cmd>FzfLua marks<cr>',                 desc = 'Jump to Mark' },
    { '<leader>sR', '<cmd>FzfLua resume<cr>',                desc = 'Resume' },
    { '<leader>sq', '<cmd>FzfLua quickfix<cr>',              desc = 'Quickfix List' },
    {
      '<leader>ss',
      function()
        require('fzf-lua').lsp_document_symbols()
      end,
      desc = 'Goto Symbol',
    },
    {
      '<leader>sS',
      function()
        require('fzf-lua').lsp_live_workspace_symbols()
      end,
      desc = 'Goto Symbol (Workspace)',
    },
    {
      '<leader>uC',
      function()
        require('fzf-lua').colorschemes()
      end,
      desc = 'Colorscheme with Preview',
    },
    {
      '<leader>sw',
      function()
        require('fzf-lua').grep_visual()
      end,
      mode = 'v',
      desc = 'Selection',
    },
    {
      '<leader>sW',
      function()
        require('fzf-lua').grep_visual()
      end,
      mode = 'v',
      desc = 'Selection (cwd)',
    },
  },
}

return {
  'nvim-telescope/telescope.nvim',
  version = false,
  keys = {
    {
      '<leader>fm',
      function()
        require('telescope.builtin').man_pages({ sections = { 'ALL' } })
      end,
      desc = 'Find Man Pages',
    },
    {
      '<leader>gf',
      function()
        require('telescope.builtin').git_files({
          hidden = true,
          no_ignore = true,
        })
      end,
      desc = 'Find git files',
    },
    {
      '<leader>fd',
      function()
        require('telescope.builtin').diagnostics()
      end,
      desc = 'Search diagnostics',
    },
    {
      '<leader>ft',
      function()
        local themes = require('plugins.ui.themes')
        for _, theme in ipairs(themes) do
          local name = theme.name and theme.name or string.match(theme[1], '([^/]+)$')
          require('lazy').load({ plugins = name })
        end
        require('telescope.builtin').colorscheme(require('telescope.themes').get_dropdown({
          layout_config = {
            anchor = 'SE',
            width = function(_, max_columns, _)
              return math.min(max_columns, 40)
            end,

            height = function(_, _, max_lines)
              return math.min(max_lines, 20)
            end,
          },
          treesitter = false,
          enable_preview = true, -- true to see the colorscheme changes in real time
          ignore_builtins = true,
          previewer = false, -- disable the previewer
          winblend = 10,
        }))
      end,
      desc = 'Find themes',
    },
    { '<leader>fk', '<cmd>Telescope keymaps<cr>', desc = 'Find Keymaps' },
    {
      '<leader>r',
      '<cmd>lua require("telescope.builtin").commands(require("telescope.themes").get_ivy()) <cr>',
      desc = 'Find Commands',
    },

    { '<leader>fv', '<cmd>lua require("telescope.builtin").vim_options()<cr>', desc = 'Find vim opts' },
    {
      '<leader>ff',
      function()
        require('telescope.builtin').find_files({ hidden = false })
      end,
      desc = 'Find files',
    },
    {
      '<C-f>',
      function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
          layout_config = {
            width = function(_, max_columns, _)
              return math.min(max_columns, 100)
            end,

            height = function(_, _, max_lines)
              return math.min(max_lines, 20)
            end,
          },
          winblend = 10,
          previewer = false,
          skip_empty_lines = true,
        }))
      end,
      desc = 'Find in buffer',
    },
    {
      '<leader>fa',
      function()
        require('telescope.builtin').find_files({
          hidden = true,
          no_ignore = true,
        })
      end,
      desc = 'Find all files',
    },

    { '<leader>fH', '<cmd>Telescope highlights<cr>', desc = 'Find Highlights' },
    {
      '<leader>fh',
      function()
        require('telescope.builtin').help_tags(require('telescope.themes').get_ivy({
          winblend = 10,
          attach_mappings = function(_, map)
            map('n', '<CR>', require('telescope.actions').select_vertical)
            map('i', '<CR>', require('telescope.actions').select_vertical)
            return true
          end,
        }))
      end,
      desc = 'Find Help',
    },
    {
      '<leader>fw',
      function()
        require('telescope.builtin').live_grep({
          additional_args = function(args)
            table.insert(args, '--hidden')
            table.insert(args, '--no-ignore')
          end,
        })
      end,
      desc = 'Find words',
    },

    {
      '<leader>bf',
      function()
        require('telescope.builtin').buffers({
          ignore_current_buffer = true,
          sort_mru = true,
          attach_mappings = function(_, map)
            map('n', 'dd', function(prompt_bufnr)
              require('telescope.actions').delete_buffer(prompt_bufnr)
            end)
            return true
          end,
        })
      end,
      desc = 'Find Buffers',
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      enabled = true,
      build = 'make',
      config = function()
        require('telescope').load_extension('fzf')
      end,
    },
    'echasnovski/mini.icons',
  },
  cmd = 'Telescope',
  opts = function()
    return {
      defaults = {
        sorting_strategy = 'ascending',
        results_title = false,
        dynamic_preview_title = true,
        layout_config = {
          horizontal = {
            prompt_position = 'top',
            preview_width = 0.6,
          },
          width = 0.9,
          height = 0.9,
          preview_cutoff = 120,
        },
        mappings = {
          i = {
            ['<c-j>'] = require('telescope.actions').move_selection_next,
            ['<c-k>'] = require('telescope.actions').move_selection_previous,
            ['<c-c>'] = function(prompt_bufnr) -- copy value
              local value = require('telescope.actions.state').get_selected_entry().value
              require('telescope.actions').close(prompt_bufnr)
              vim.fn.setreg('+', value)
              vim.notify(value, nil, { title = 'Copied', icon = '󰅍' })
            end,
          },
          n = {
            ['q'] = require('telescope.actions').close,
            ['v'] = require('telescope.actions').select_vertical,
            ['h'] = require('telescope.actions').select_horizontal,
            ['t'] = require('telescope.actions').select_tab,
          },
        },
        preview = {
          timeout = 500,
          filesize_limit = 1,
          treesitter = false,
        },
        treesitter = false,
      },
      pickers = {
        find_files = {
          find_command = { 'rg', '--no-config', '--files', '--sortr=modified' },
        },
        current_buffer_fuzzy_find = {
          tiebreak = function(current_entry, existing_entry)
            -- returning true means preferring current entry
            -- sort equal results by line number
            return current_entry.lnum < existing_entry.lnum
          end,
        },
        live_grep = {
          disable_coordinates = true,
          layout_config = { horizontal = { preview_width = 0.7 } },
        },
        lsp_references = {
          trim_text = true,
          show_line = false,
          include_declaration = false,
          include_current_line = true,
          layout_config = { horizontal = { preview_width = { 0.7, min = 30 } } },
        },
        colorscheme = {
          ignore_builtins = true,
          enable_preview = true,
          layout_config = {
            horizontal = {
              height = 0.4,
              width = 0.3,
              anchor = 'SE',
              preview_width = 1, -- needs previewer for live preview of the theme
            },
          },
        },
      },
      extensions = {
        fzf = {
          --     -- These are the defaults
          --     -- fuzzy = true, -- false will only do exact matching
          --     -- override_generic_sorter = true, -- override the generic sorter
          --     -- override_file_sorter = true, -- override the file sorter
          --     -- case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          --     -- -- the default case_mode is "smart_case"
        },
      },
    }
  end,
}

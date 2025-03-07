return {
  {
    'obsidian-nvim/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = true,
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
      'BufReadPre '
        .. vim.fn.expand('~')
        .. '/vaults/gersi_notes/**.md',
      'BufNewFile ' .. vim.fn.expand('~') .. '/valuts/gersi_notes/**.md',
    },
    dependencies = {
      -- Required.
      'nvim-lua/plenary.nvim',
    },
    ---@type obsidian.config.ClientOpts | table<string, any>
    opts = {
      workspaces = {
        {
          name = 'gersi_notes',
          path = '~/vaults/gersi_notes/',
        },
      },
      completion = {
        -- FIX: next time you're here https://github.com/epwalsh/obsidian.nvim/issues/770
        nvim_cmp = false,
        blink = true,
        min_chars = 0,
      },
      mappings = {
        ['gd'] = {
          action = function()
            return require('obsidian').util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Smart action depending on context, either follow link or toggle checkbox.
        ['<cr>'] = {
          action = function()
            return require('obsidian').util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
      },
      -- Optional, customize how note IDs are generated given an optional title.
      ---@param title string|?
      ---@return string
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local suffix = ''
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
        else
          -- If title is nil, ask user for a tile.
          suffix = vim.fn.input({ prompt = 'Commit message: ', default = nil })
          -- If user cancels, generate a random 4 letter suffix.
          if suffix == nil then
            for _ = 1, 4 do
              suffix = suffix .. string.char(math.random(65, 90))
            end
          end
        end
        return suffix
      end,
      follow_url_func = function(url)
        -- Open URLs in the browser.
        vim.fn.jobstart({ 'google-chrome-stable', url })
      end,
      picker = {
        name = 'telescope.nvim',
        note_mappings = {
          new = '<C-n>',
          insert_link = '<C-l>',
        },
        tag_mappings = {
          tag_note = '<C-n>',
          insert_tag = '<C-i>',
        },
      },
    },
  },
}

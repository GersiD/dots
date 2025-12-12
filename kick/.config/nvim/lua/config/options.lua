-- Add any additional options here
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.o.termguicolors = true
vim.opt.winbar = '%=%m %f %r %h%w'
-- Set highlight on search
vim.o.hlsearch = true
-- Make line numbers default
vim.wo.number = true
-- Enable break indent
vim.o.breakindent = true
-- Save undo history
vim.o.undofile = true
-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true
-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'
-- Set completeopt to have a better completion experience
-- vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true
vim.g.nofsync = true
vim.g.python_host_skip_check = true
vim.g.python3_host_skip_check = true
if jit.os == 'Windows' then
  vim.g.python3_host_prog = '~/scoop/apps/python/current/python.exe'
  vim.g.clipboard = {
    name = 'win32yank',                  -- set clipboard provider
    copy = {
      ['+'] = 'win32yank.exe -i --crlf', -- copy to clipboard
      ['*'] = 'win32yank.exe -i --crlf', -- copy to clipboard
    },
    paste = {
      ['+'] = 'win32yank.exe -o --lf', -- paste from clipboard
      ['*'] = 'win32yank.exe -o --lf', -- paste from clipboard
    },
  }
else
  if vim.env.SSH_CLIENT or vim.env.SSH_CONNECTION or vim.env.SSH_TTY then -- Current session is over SSH
    vim.g.clipboard = {                                                   -- Default clipboard is x11
      name = 'xclip',
      copy = {
        ['+'] = 'xclip -selection clipboard',
        ['*'] = 'xclip -selection primary',
      },
      paste = {
        ['+'] = 'xclip -selection clipboard -o',
        ['*'] = 'xclip -selection primary -o',
      },
      cache_enabled = true,
    }
    -- Use wl-clipboard if $WAYLAND_DISPLAY is set
    if vim.env.WAYLAND_DISPLAY ~= nil then
      vim.g.clipboard = {
        name = 'wl-copy',
        copy = {
          ['+'] = 'wl-copy',
          ['*'] = 'wl-copy',
        },
        paste = {
          ['+'] = 'wl-paste -n',
          ['*'] = 'wl-paste -n',
        },
        cache_enabled = true,
      }
    end
  else                                -- local nvim session
    vim.opt.clipboard = 'unnamedplus' -- Use system clipboard
  end
end
vim.g.ruby_host_skip_check = true
vim.g.perl_host_skip_check = true
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

vim.opt.conceallevel = 1
vim.opt.autowrite = true           -- Enable auto write
vim.opt.clipboard = 'unnamedplus'  -- Sync with system clipboard
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.confirm = true             -- Confirm to save changes before exiting modified buffer
vim.opt.cursorline = true          -- Enable highlighting of the current line
vim.opt.expandtab = true           -- Use spaces instead of tabs
vim.opt.formatoptions = 'jcroqlnt' -- tcqj
vim.opt.grepformat = '%f:%l:%c:%m'
vim.opt.grepprg = 'rg --vimgrep'
vim.opt.ignorecase = true      -- Ignore case
vim.opt.inccommand = 'nosplit' -- preview incremental substitute
vim.opt.laststatus = 0
vim.opt.list = true            -- Show some invisible characters (tabs...
vim.opt.mouse = 'a'            -- Enable mouse mode
vim.opt.number = true          -- Print line number
vim.opt.pumblend = 10          -- Popup blend
vim.opt.pumheight = 10         -- Maximum number of entries in a popup
vim.opt.relativenumber = true  -- Relative line numbers
vim.opt.scrolloff = 4          -- Lines of context
vim.opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize' }
vim.opt.shiftround = true      -- Round indent
vim.opt.shiftwidth = 2         -- Size of an indent
vim.opt.shortmess:append({ W = true, I = true, c = true })
vim.opt.showmode = false       -- Dont show mode since we have a statusline
vim.opt.sidescrolloff = 8      -- Columns of context
vim.opt.signcolumn = 'yes'     -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.smartcase = true       -- Don't ignore case with capitals
vim.opt.smartindent = true     -- Insert indents automatically
vim.opt.spelllang = { 'en' }
vim.opt.splitbelow = true      -- Put new windows below current
vim.opt.splitright = true      -- Put new windows right of current
vim.opt.tabstop = 2            -- Number of spaces tabs count for
vim.opt.termguicolors = true   -- True color support
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 200               -- Save swap file and trigger CursorHold
vim.opt.wildmode = 'longest:full,full' -- Command-line completion mode
vim.opt.winminwidth = 5                -- Minimum window width
vim.opt.textwidth = 120                -- Maximum width of text
vim.opt.wrap = true                    -- enable line wrap
vim.opt.wrapmargin = 2                 -- wrap lines at 80 characters
vim.opt.linebreak = true               -- wrap lines at convenient points
vim.opt.columns = 120
vim.opt.colorcolumn = '100'            -- highlight column 100
vim.opt.splitkeep = 'screen'
vim.opt.shortmess:append({ C = true })

vim.opt.guifont = { 'FiraCode Nerd Font Ret', ':h14' }
-- disable folding
vim.opt.foldenable = false

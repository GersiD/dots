-- Add any additional options here
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.opt.winbar = '%=%m %f %r %h%w'
-- Set highlight on search
vim.o.hlsearch = true
-- Enable break indent
vim.o.breakindent = true
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
elseif (vim.env.SSH_CLIENT or vim.env.SSH_CONNECTION or vim.env.SSH_TTY) and vim.fn.has('nvim-0.10') == 1 then
  -- OSC 52 hands yanks to the local terminal, so they land on the local clipboard with no
  -- clipboard tools or X forwarding on the remote. Paste reads nvim's own register because
  -- terminals prompt (kitty) or refuse when a program asks to read the clipboard.
  local osc52 = require('vim.ui.clipboard.osc52')
  local function paste()
    return { vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('') }
  end
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = { ['+'] = osc52.copy('+'), ['*'] = osc52.copy('*') },
    paste = { ['+'] = paste, ['*'] = paste },
  }
end
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0

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
vim.opt.laststatus = 3
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
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
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
vim.g.tex_fold_enabled = 0             -- disable folding in LaTeX
vim.g.tex_nospell = 1                  -- disable spell checking in LaTeX
vim.opt.linebreak = true               -- wrap lines at convenient points
vim.opt.colorcolumn = '100'            -- highlight column 100
vim.opt.splitkeep = 'screen'
vim.o.winborder = 'single'

vim.opt.guifont = { 'FiraCode Nerd Font Ret', ':h18' }
vim.g.neovide_input_macos_option_key_is_meta = 'only_left'
-- disable folding
vim.opt.foldenable = false

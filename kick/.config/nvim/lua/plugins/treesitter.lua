---@module "lazy"
---@type LazySpec
return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'main',
  build = ':TSUpdate',
  config = function()
    local ts = require('nvim-treesitter')
    -- registry of every parser nvim-treesitter knows how to build
    local parsers = require('nvim-treesitter.parsers')

    ts.install({
      'markdown', 'regex', 'bash', 'c', 'cpp', 'go', 'lua',
      'python', 'ninja', 'toml', 'rst', 'rust', 'tsx',
      'javascript', 'typescript', 'vimdoc', 'vim', 'hyprlang',
    })

    -- filetypes that never get treesitter (UI buffers, pickers)
    local ignore_ft = {
      snacks = true,
      fidget = true,
      noice = true,
      alpha = true,
      blink = true,
      bigfile = true,
      flash = true,
      oil = true,
      TelescopePrompt = true,
      TelescopeResults = true,
      toggleterm = true,
      qf = true,
      fzf = true,
      fzflua = true,
    }

    -- languages handled by another highlighter (vimtex owns latex)
    local ignore_lang = {}

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('TreesitterSetup', { clear = true }),
      desc = 'Enable treesitter highlighting and indentation',
      callback = function(ev)
        -- terminal/prompt scratch buffers (fzf-lua, toggleterm, ...) have no source to parse
        local buftype = vim.bo[ev.buf].buftype
        if buftype == 'terminal' or buftype == 'prompt' then return end
        if ignore_ft[ev.match:match('^[^_-]+')] then return end

        local lang = vim.treesitter.language.get_lang(ev.match)
        if not lang or ignore_lang[lang] then return end
        -- no parser exists upstream (e.g. `fzflua_backdrop`): installing it only warns
        if not parsers[lang] then return end

        if not pcall(vim.treesitter.start, ev.buf, lang) then
          ts.install(lang)
          return
        end

        vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}

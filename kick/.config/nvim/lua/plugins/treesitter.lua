---@module "lazy"
---@type LazySpec
return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'main',
  build = ':TSUpdate',
  config = function()
    local ts = require('nvim-treesitter')

    -- Install core parsers at startup
    ts.install({
      'markdown',
      'regex',
      'bash',
      'c',
      'cpp',
      'go',
      'lua',
      'python',
      'ninja',
      'toml',
      'rst',
      'rust',
      'tsx',
      'javascript',
      'typescript',
      'vimdoc',
      'vim',
      'hyprlang',
    })

    local group = vim.api.nvim_create_augroup('TreesitterSetup', { clear = true })

    local ignore_filetypes = {
      'snacks',
      'fidget',
      'noice',
      'alpha',
      'blink-cmp-menu',
      'bigfile',
      'flash',
      'oil',
      'TelescopePrompt',
      'TelescopeResults',
      'toggleterm'
    }

    -- Auto-install parsers and enable highlighting on FileType
    vim.api.nvim_create_autocmd('FileType', {
      group = group,
      desc = 'Enable treesitter highlighting and indentation',
      callback = function(event)
        local lang = vim.treesitter.language.get_lang(event.match)
        if not lang or vim.tbl_contains(ignore_filetypes, event.match:match("[^_]+")) then
          return
        end

        local buf = event.buf

        -- Start highlighting immediately (only works if parser exists)
        pcall(vim.treesitter.start, buf, lang)

        -- Enable treesitter indentation
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

        -- Install parser if not already installed
        ts.install(lang)
      end,
    })
  end,
}

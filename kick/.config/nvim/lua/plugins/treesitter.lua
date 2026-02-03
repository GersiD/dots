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
      'blink',
      'bigfile',
      'flash',
      'oil',
      'TelescopePrompt',
      'TelescopeResults',
      'toggleterm',
      'qf'
    }

    -- Auto-install parsers and enable highlighting on FileType
    vim.api.nvim_create_autocmd('FileType', {
      group = group,
      desc = 'Enable treesitter highlighting and indentation',
      callback = function(event)
        local lang = vim.treesitter.language.get_lang(event.match)
        if not lang
            or vim.tbl_contains(ignore_filetypes, event.match:match("[^_]+"))
            or vim.tbl_contains(ignore_filetypes, event.match:match("[^-]+")) then
          return
        end

        local buf = event.buf

        -- Start highlighting immediately (only works if parser exists)
        local has_parser = pcall(vim.treesitter.start, buf, lang)
        if not has_parser then
          ts.install(lang)
        end

        -- Enable treesitter indentation
        if lang ~= "latex" then
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}

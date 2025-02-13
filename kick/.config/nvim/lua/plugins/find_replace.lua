return {
  'chrisgrieser/nvim-rip-substitute',
  cmd = 'RipSubstitute',
  keys = {
    {
      '<leader>fr',
      function()
        require('rip-substitute').sub()
      end,
      mode = { 'n', 'x' },
      desc = ' rip substitute',
    },
  },
  opts = {
    regexOptions = {
      -- pcre2 enables lookarounds and backreferences, but performs slower
      pcre2 = false,
      ---@type "case-sensitive"|"ignore-case"|"smart-case"
      casing = 'smart-case',
    },
  },
}

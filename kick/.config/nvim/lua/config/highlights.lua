vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { link = '@markup.link' })
vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { link = '@markup.link' })
vim.api.nvim_set_hl(0, 'IlluminatedWordText', { link = '@markup.link' })
vim.api.nvim_set_hl(0, '@markup.italic', { link = '@string.special.uri' }) -- link one highlight to another
vim.cmd('highlight PMenuSel guifg=None guibg=#1d2021')
vim.cmd('highlight MatchParen guifg=None guibg=#1d20FF')

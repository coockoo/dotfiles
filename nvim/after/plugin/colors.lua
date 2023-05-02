vim.cmd.colorscheme('OceanicNext')

vim.api.nvim_set_hl(0, '@tag', { link = '@function' })
vim.api.nvim_set_hl(0, '@constructor.tsx', { link = '@function' })
vim.api.nvim_set_hl(0, '@tag.delimiter.tsx', { link = '@function' })
vim.api.nvim_set_hl(0, '@property', { link = 'Identifier' })
vim.api.nvim_set_hl(0, '@tag.attribute.tsx', { link = 'Identifier' })

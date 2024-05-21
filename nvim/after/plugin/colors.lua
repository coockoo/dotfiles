vim.cmd.colorscheme('OceanicNext')

vim.api.nvim_set_hl(0, '@tag', { link = '@function' })
vim.api.nvim_set_hl(0, '@constructor.tsx', { link = '@function' })
vim.api.nvim_set_hl(0, '@tag.builtin.tsx', { link = '@function' })
vim.api.nvim_set_hl(0, '@tag.delimiter.tsx', { link = '@function' })
vim.api.nvim_set_hl(0, '@tag.attribute.tsx', { link = 'Identifier' })
vim.api.nvim_set_hl(0, 'diffAdded', { link = 'DiffNewFile' })
vim.api.nvim_set_hl(0, 'diffRemoved', { link = 'DiffFile' })

for i = 1, 6, 1 do
  vim.api.nvim_set_hl(0, '@markup.heading.' .. i .. '.markdown', { link = 'Title' })
  vim.api.nvim_set_hl(0, '@markup.heading.' .. i .. '.marker.markdown', { link = 'Title' })
end
vim.api.nvim_set_hl(0, '@markup.raw.markdown_inline', { link = 'Float' })
vim.api.nvim_set_hl(0, '@markup.raw.block.markdown', { link = 'Comment' })
vim.api.nvim_set_hl(0, '@markup.link.url.markdown', { link = 'Underlined' })
vim.api.nvim_set_hl(0, '@markup.link.markdown_inline', { link = 'Underlined' })
vim.api.nvim_set_hl(0, '@markup.link.label.markdown_inline', { link = 'Underlined' })
vim.api.nvim_set_hl(0, '@markup.link.label.markdown', { link = 'Underlined' })

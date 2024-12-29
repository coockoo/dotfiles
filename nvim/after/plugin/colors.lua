vim.cmd.colorscheme('OceanicNext')

---@param name string
---@param val vim.api.keyset.highlight
local function hl(name, val)
  vim.api.nvim_set_hl(0, name, val)
end

hl('@tag', { link = '@function' })
hl('@constructor.tsx', { link = '@function' })
hl('@tag.builtin.tsx', { link = '@function' })
hl('@tag.delimiter.tsx', { link = '@function' })
hl('@tag.attribute.tsx', { link = 'Identifier' })
hl('diffAdded', { link = 'DiffNewFile' })
hl('diffRemoved', { link = 'DiffFile' })
for i = 1, 6, 1 do
  hl('@markup.heading.' .. i .. '.markdown', { link = 'Title' })
  hl('@markup.heading.' .. i .. '.marker.markdown', { link = 'Title' })
end
hl('@markup.raw.markdown_inline', { link = 'Float' })
hl('@markup.raw.block.markdown', { link = 'Comment' })
hl('@markup.link.url.markdown', { link = 'Underlined' })
hl('@markup.link.markdown_inline', { link = 'Underlined' })
hl('@markup.link.label.markdown_inline', { link = 'Underlined' })
hl('@markup.link.label.markdown', { link = 'Underlined' })

local success, cmp = pcall(require, 'cmp')
if not success then
  return
end

require('luasnip.loaders.from_snipmate').lazy_load()

local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    -- disabled due to copilot, now not needed
    ['<Tab>'] = nil,
    ['<S-Tab>'] = nil,
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
})

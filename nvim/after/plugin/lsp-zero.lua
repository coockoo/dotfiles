local lsp_zero = require('lsp-zero').preset({})

-- todo: remove lspzero in favour of lspconfig
-- todo: remove null-ls for same reasons

--[[
-- in case some keymaps are missing – look here
lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr })
end)
]] --

-- todo: migrate eslint to lspconfig + efm too
local null_ls = require('null-ls')
null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint_d,
  }
})

lsp_zero.setup()

require('luasnip.loaders.from_snipmate').lazy_load()

local cmp = require('cmp')
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
  formatting = lsp_zero.cmp_format(),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }
})

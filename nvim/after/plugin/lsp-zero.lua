local lsp_zero = require('lsp-zero').preset({})
lsp_zero.setup()

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
  },
})

require('luasnip.loaders.from_snipmate').lazy_load()

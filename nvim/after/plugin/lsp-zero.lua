local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
  lsp.buffer_autoformat()
end)

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.ensure_installed({
  "tsserver",
  "eslint",
})


local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_action = require('lsp-zero').cmp_action()

local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
  ['<CR>'] = cmp.mapping.confirm({ select = true }),
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

local null_ls = require("null-ls")
local null_opts = lsp.build_options('null-ls', {
  on_attach = function(client)
    -- if client.resolved_capabilities.document_formatting then
      vim.api.nvim_create_autocmd("BufWritePre", {
        desc = "Auto format before save",
        pattern = "<buffer>",
        callback = vim.lsp.buf.format,
      })
    -- end
  end
})

null_ls.setup({
  on_attach = null_opts.on_attach,
  sources = {
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.diagnostics.eslint,
  }
})

lsp.setup()

vim.diagnostic.config({
  virtual_text = true
})

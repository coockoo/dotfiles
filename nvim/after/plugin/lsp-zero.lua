local lsp_zero = require('lsp-zero').preset({})

-- todo: remove lspzero in favour of lspconfig
-- todo: remove null-ls for same reasons
-- this thing exists
-- vim.lsp.buf.format({ async = true })

--- @param client vim.lsp.Client
--- @param bufnr integer
local filter = function(client, bufnr)
  local ft = vim.bo[bufnr].filetype
  return (
    ft ~= 'yaml' and ft ~= 'haskell'
    and client.name ~= 'tsserver' and client.name ~= 'ts_ls'
  )
end

--[[
-- in case some keymaps are missing – look here
lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr })
end)
]] --


lsp_zero.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

-- todo: think about naming
local lsp_group = vim.api.nvim_create_augroup('my_lsp', {})
vim.api.nvim_create_autocmd('LspAttach', {
  group = lsp_group,
  desc = 'lsp configuration on buffer enter',
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end
    client.server_capabilities.semanticTokensProvider = nil
  end
})

-- todo: migrate eslint to lspconfig + efm too
local null_ls = require('null-ls')
null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint_d,
  }
})

lsp_zero.setup()

vim.diagnostic.config({
  virtual_text = true
})

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

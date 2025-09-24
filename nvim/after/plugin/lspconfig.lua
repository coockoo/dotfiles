local lspconfig = require('lspconfig')

-- setup typescript lsp server
lspconfig.ts_ls.setup({
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  --- @param client vim.lsp.Client
  on_init = function(client)
    client.server_capabilities.semanticTokensProvider = nil
    client.server_capabilities.documentFormattingProvider = nil
  end,
})

-- setup yaml lsp server
lspconfig.yamlls.setup({
  settings = {
    yaml = {
      keyOrdering = false,
    },
  },
})

lspconfig.hls.setup({
  filetypes = { 'haskell', 'cabal' },
})

lspconfig.marksman.setup({})

local htmlCap = vim.lsp.protocol.make_client_capabilities()
htmlCap.textDocument.completion.completionItem.snippetSupport = true
lspconfig.html.setup({
  capabilities = htmlCap,
})

lspconfig.zls.setup({
  on_init = function(client)
    client.server_capabilities.semanticTokensProvider = nil
    client.server_capabilities.documentFormattingProvider = nil
  end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
lspconfig.cssls.setup({
  capabilities = capabilities,
})

lspconfig.pylsp.setup({
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = { enabled = false },
        ruff = { enabled = true },
      },
    },
  },
})

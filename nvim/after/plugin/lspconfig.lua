-- setup typescript lsp server
vim.lsp.config('ts_ls', {
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  --- @param client vim.lsp.Client
  on_init = function(client)
    client.server_capabilities.semanticTokensProvider = nil
    client.server_capabilities.documentFormattingProvider = nil
  end,
})

-- setup yaml lsp server
vim.lsp.config('yamlls', {
  settings = {
    yaml = {
      keyOrdering = false,
    },
  },
})

vim.lsp.config('hls', {
  filetypes = { 'haskell', 'cabal' },
})

vim.lsp.config('marksman', {})

local htmlCap = vim.lsp.protocol.make_client_capabilities()
htmlCap.textDocument.completion.completionItem.snippetSupport = true
vim.lsp.config('html', {
  capabilities = htmlCap,
})

vim.lsp.config('zls', {
  on_init = function(client)
    client.server_capabilities.semanticTokensProvider = nil
    client.server_capabilities.documentFormattingProvider = nil
  end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.lsp.config('cssls', {
  capabilities = capabilities,
})

vim.lsp.config('pylsp', {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = { enabled = false },
        ruff = { enabled = true },
      },
    },
  },
})
vim.lsp.enable({ 'ts_ls', 'yamlls', 'hls', 'marksman', 'html', 'zls', 'cssls', 'pylsp' })

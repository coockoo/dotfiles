local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.lsp.config('jsonls', {
  capabilities = capabilities,
  settings = {
    json = {
      schemas = {
        {
          fileMatch = { 'package.json' },
          url = 'https://json.schemastore.org/package.json',
        },
        {
          fileMatch = { 'tsconfig.json' },
          url = 'https://json.schemastore.org/tsconfig.json',
        },
      },
    },
  },
})
vim.lsp.enable('jsonls')

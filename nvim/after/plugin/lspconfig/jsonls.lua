local success, lspconfig = pcall(require, 'lspconfig')
if not success then
  vim.notify('lspconfig/jsonls: cannot require lspconfig', vim.log.levels.ERROR)
  return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
lspconfig.jsonls.setup({
  capabilities = capabilities,
  settings = {
    json = {
      schemas = {
        {
          fileMatch = { 'package.json' },
          url = 'https://json.schemastore.org/package.json',
        },
      },
    },
  },
})

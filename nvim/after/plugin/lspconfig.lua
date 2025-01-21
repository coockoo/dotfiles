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

-- TODO: add this thing
local function handleLspProgress(ev)
  -- debug info
  -- vim.print('progress', vim.inspect(ev))

  -- https://github.com/microsoft/language-server-protocol/issues/786
  --[[
  --{
  buf = 8,
  data = {
    client_id = 1,
    params = {
      token = 3,
      value = {
        kind = "report",
        message = "1008/1033",
        percentage = 97,
        title = "Loading workspace"
      }
    }
  },
  event = "LspProgress",
  file = "report",
  id = 51,
  match = "/Users/coockoo/dev/coockoo/dotfiles/report"
}
  ]] --
end
-- vim.api.nvim_create_autocmd('LspProgress', { callback = handleLspProgress })

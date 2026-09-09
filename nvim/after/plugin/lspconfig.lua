local util = require('lspconfig.util')

-- setup typescript lsp server
vim.lsp.config('ts_ls', {
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local root = (
      util.root_pattern('tsconfig.json', 'jsconfig.json')(fname) or
      util.root_pattern('package.json', '.git')(fname)
    )
    on_dir(root)
  end,
  --- @param client vim.lsp.Client
  on_init = function(client)
    client.server_capabilities.semanticTokensProvider = nil
    client.server_capabilities.documentFormattingProvider = nil
  end,
  settings = {
    typescript = {
      preferences = {
        preferTypeOnlyAutoImports = true,
      },
    },
    javascript = {
      preferences = {
        preferTypeOnlyAutoImports = true,
      },
    },
  },
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

local success, lspconfig = pcall(require, 'lspconfig')
if not success then
  vim.notify('lspconfig/efm: cannot require lspconfig', vim.log.levels.ERROR)
  return
end

-- setup efm lsp server
-- https://github.com/mattn/efm-langserver

local prettier = { formatCommand = 'prettierd "${INPUT}"', formatStdin = true }
local swiftFormat = { formatCommand = 'swift-format -', formatStdin = true }

local languages = {
  javascript = { prettier },
  javascriptreact = { prettier },
  typescript = { prettier },
  typescriptreact = { prettier },
  scss = { prettier },
  css = { prettier },
  json = { prettier },
  html = { prettier },
  swift = { swiftFormat },
}

local group = vim.api.nvim_create_augroup('lsp_format_on_save_efm', { clear = false })
lspconfig.efm.setup({
  --- @param client vim.lsp.Client
  --- @param buffer integer
  on_attach = function(client, buffer)
    if client:is_stopped() or not client:supports_method('textDocument/formatting', buffer) then
      return
    end
    vim.api.nvim_clear_autocmds({ buffer = buffer, group = group })
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = buffer,
      group = group,
      desc = 'Auto format before save',
      callback = function()
        vim.lsp.buf.format({ id = client.id, bufnr = buffer })
      end,
    })
  end,
  init_options = { documentFormatting = true },
  filetypes = vim.tbl_keys(languages),
  settings = {
    languages = languages,
  },
})

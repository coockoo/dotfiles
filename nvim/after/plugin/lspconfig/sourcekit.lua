local success, lspconfig = pcall(require, 'lspconfig')
if not success then
  vim.notify('lspconfig/sourcekit: cannot require lspconfig', vim.log.levels.ERROR)
  return
end

lspconfig.sourcekit.setup({
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  },
})

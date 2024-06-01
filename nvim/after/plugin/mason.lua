local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local lspconfig = require('lspconfig')
local lsp_zero = require('lsp-zero')

mason.setup({
  PATH = 'prepend', -- "skip" seems to cause the spawning error
})

mason_lspconfig.setup({
  ensure_installed = { 'tsserver', 'lua_ls' },
  handlers = {
    function(server_name)
      lspconfig[server_name].setup({})
    end,

    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      lspconfig.lua_ls.setup(lua_opts)
    end,

    eslint = lsp_zero.noop
  },
})

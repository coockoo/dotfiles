local lspconfig = require('lspconfig')

-- setup typescript lsp server
lspconfig.ts_ls.setup({})

-- setup lua lsp server
-- todo: remove lsp_zero in favour of raw lspconfig
local lsp_zero = require('lsp-zero')
local lua_opts = lsp_zero.nvim_lua_ls({
  settings = {
    Lua = {
      -- https://github.com/CppCXY/EmmyLuaCodeStyle/blob/master/docs/format_config_EN.md
      format = {
        enable = true,
        defaultConfig = {
          indent_style = 'space',
          indent_size = '2',
          quote_style = 'single',
        }
      },
    }
  }
})
lspconfig.lua_ls.setup(lua_opts)

-- setup yaml lsp server
lspconfig.yamlls.setup({
  settings = {
    yaml = {
      keyOrdering = false
    }
  }
})

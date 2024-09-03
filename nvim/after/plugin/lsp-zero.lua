local lsp_zero = require('lsp-zero').preset({})
local lspconfig = require('lspconfig')
local cmp = require('cmp')

-- todo: remove lspzero in favour of lspconfig
-- todo: remove null-ls for same reasons

--- @param client vim.lsp.Client
--- @param bufnr integer
local filter = function(client, bufnr)
  local ft = vim.bo[bufnr].filetype
  return (
    ft ~= 'yaml' and ft ~= 'haskell'
    and client.name ~= 'tsserver'
  )
end

lsp_zero.on_attach(function(client, bufnr)
  client.server_capabilities.semanticTokensProvider = nil
  if filter(client, bufnr) then
    lsp_zero.buffer_autoformat(client, bufnr)
  end
end)

lspconfig.lua_ls.setup(lsp_zero.nvim_lua_ls({
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
}))

lspconfig.yamlls.setup({
  settings = {
    yaml = {
      keyOrdering = false
    }
  }
})

lsp_zero.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

local group = vim.api.nvim_create_augroup('lsp_format_on_save', { clear = false })
local null_ls = require('null-ls')
local null_opts = lsp_zero.build_options('null-ls', {
  --- @param client vim.lsp.Client
  --- @param bufnr integer
  on_attach = function(client, bufnr)
    if not client.supports_method('textDocument/formatting') then
      return
    end
    client.server_capabilities.semanticTokensProvider = nil
    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      group = group,
      desc = 'Auto format before save',
      callback = function()
        if not vim.lsp.buf_is_attached(bufnr, client.id) or vim.lsp.client_is_stopped(client.id) then
          return
        end
        vim.lsp.buf.format({
          bufnr = bufnr,
          filter = function() return filter(client, bufnr) end
        })
      end,
    })
  end
})

null_ls.setup({
  on_attach = null_opts.on_attach,
  sources = {
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.formatting.black,
  }
})

lsp_zero.setup()

vim.diagnostic.config({
  virtual_text = true
})

require('luasnip.loaders.from_snipmate').lazy_load()

local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    -- disabled due to copilot, now not needed
    ['<Tab>'] = nil,
    ['<S-Tab>'] = nil,
  }),
  formatting = lsp_zero.cmp_format(),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }
})

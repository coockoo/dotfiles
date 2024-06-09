local lsp_zero = require('lsp-zero').preset({})
local lspconfig = require('lspconfig')
local cmp = require('cmp')

local filter = function(client, bufnr)
  return vim.bo[bufnr].filetype ~= 'yaml' and client.name ~= 'tsserver'
end

lsp_zero.on_attach(function(client, bufnr)
  client.server_capabilities.semanticTokensProvider = nil
  lsp_zero.default_keymaps({ buffer = bufnr })
  lsp_zero.buffer_autoformat(client, bufnr, {
    filter = function() filter(client, bufnr) end
  })

  vim.keymap.set('n', '<leader>rr', function() vim.lsp.buf.references() end, { buffer = bufnr, desc = 'references' })
  vim.keymap.set('n', '<leader>rn', function() vim.lsp.buf.rename() end, { buffer = bufnr, desc = 'rename' })
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
  on_attach = function(client, bufnr)
    client.server_capabilities.semanticTokensProvider = nil
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        group = group,
        desc = 'Auto format before save',
        callback = function()
          vim.lsp.buf.format({
            bufnr = bufnr,
            filter = function() return filter(client, bufnr) end
          })
        end,
      })
    end
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
    -- copilot conflicts
    ['<Tab>'] = nil,
    ['<S-Tab>'] = nil,
  }),
  formatting = lsp_zero.cmp_format(),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }
})

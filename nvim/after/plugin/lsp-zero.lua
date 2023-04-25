local lsp = require('lsp-zero').preset({})
local lspconfig = require('lspconfig')

lsp.on_attach(function(client, bufnr)
  client.server_capabilities.semanticTokensProvider = nil
  lsp.default_keymaps({ buffer = bufnr })
  lsp.buffer_autoformat(client, bufnr, {
    filter = function()
      return vim.bo[bufnr].filetype ~= 'yaml'
    end
  })
end)

lspconfig.lua_ls.setup(lsp.nvim_lua_ls({
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

lsp.ensure_installed({
  'tsserver',
  'eslint',
})


local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
  ['<CR>'] = cmp.mapping.confirm({ select = true }),
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

lsp.skip_server_setup({ 'eslint' })

local group = vim.api.nvim_create_augroup('lsp_format_on_save', { clear = false })
local null_ls = require('null-ls')
local null_opts = lsp.build_options('null-ls', {
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
            filter = function()
              return vim.bo[bufnr].filetype ~= 'yaml'
            end
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
  }
})

lsp.setup()

vim.diagnostic.config({
  virtual_text = true
})

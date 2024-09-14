local lspconfig = require('lspconfig')

-- setup typescript lsp server
lspconfig.ts_ls.setup({})

-- setup lua lsp server
local function get_packer_modules ()
  local start_path = vim.fs.joinpath(require('packer').config.package_root, 'packer', 'start')
  local res = {}
  for file in vim.fs.dir(start_path) do
    local file_path = vim.fs.joinpath(start_path, file)
    local luadir = vim.fs.find({ 'lua' }, { path = file_path,   })
    if #luadir > 0 then
      table.insert(res, luadir[1])
    end
  end
  return res
end
local lua_library = vim.list_extend({ vim.env.VIMRUNTIME }, get_packer_modules())
lspconfig.lua_ls.setup({
  -- https://luals.github.io/wiki/settings/
  settings = {
    Lua = {
      telemetry = { enable = false },
      format = {
        enable = true,
        defaultConfig = {
          indent_style = 'space',
          indent_size = '2',
          quote_style = 'single',
        }
      },
      workspace = {
        checkThirdParty = false,
        library = lua_library,
      }
    }
  }
})

-- setup yaml lsp server
lspconfig.yamlls.setup({
  settings = {
    yaml = {
      keyOrdering = false
    }
  }
})

-- setup efm lsp server
-- https://github.com/mattn/efm-langserver
local prettier = {
  formatCommand = 'prettierd "${INPUT}"',
  formatStdin = true,
}
local group = vim.api.nvim_create_augroup('lsp_format_on_save', { clear = false })
lspconfig.efm.setup({
  --- @param client vim.lsp.Client
  --- @param buffer integer
  on_attach = function(client, buffer)
    if not client.supports_method('textDocument/formatting') or client.is_stopped() then
      return
    end
    vim.api.nvim_clear_autocmds({ buffer = buffer, group = group })
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = buffer,
      group = group,
      desc = 'Auto format before save',
      callback = function ()
        vim.lsp.buf.format({ bufnr = buffer })
      end
    })
  end,
  init_options = { documentFormatting = true },
  filetypes = { 'typescript', 'javascript' },
  settings = {
    languages = {
      typescript = { prettier },
      javascript = { prettier },
    },
  },
})

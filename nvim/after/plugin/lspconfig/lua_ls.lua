local success, lspconfig = pcall(require, 'lspconfig')
if not success then
  vim.notify('lspconfig/lua_ls: cannot require lspconfig', vim.log.levels.ERROR)
  return
end

-- setup lua lsp server
-- https://luals.github.io/wiki/settings/

local function get_packer_modules()
  local start_path = vim.fs.joinpath(require('packer').config.package_root, 'packer', 'start')

  local res = {}
  for file in vim.fs.dir(start_path) do
    local file_path = vim.fs.joinpath(start_path, file)
    local luadir = vim.fs.find({ 'lua' }, { path = file_path })
    if #luadir > 0 then
      table.insert(res, luadir[1])
    end
  end
  return res
end

local lua_library = vim.list_extend({ vim.env.VIMRUNTIME }, get_packer_modules())

local group = vim.api.nvim_create_augroup('lsp_format_on_save_lua_ls', { clear = false })
lspconfig.lua_ls.setup({
  filetypes = { 'lua' },
  --- @param client vim.lsp.Client
  on_init = function(client)
    client.server_capabilities.semanticTokensProvider = nil
  end,
  --- @param client vim.lsp.Client
  --- @param buffer integer
  on_attach = function(client, buffer)
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
  settings = {
    Lua = {
      telemetry = { enable = false },
      format = {
        enable = true,
        defaultConfig = {
          -- https://github.com/CppCXY/EmmyLuaCodeStyle/blob/1e04543de6c80afd8e104b6d1fb14f53be12300c/docs/format_config_EN.md
          call_arg_parentheses = 'keep',
          indent_style = 'space',
          indent_size = '2',
          quote_style = 'single',
          trailing_table_separator = 'smart',
          line_space_after_local_or_assign_statement = 'max(2)',
          line_space_after_expression_statement = 'max(2)',
        },
      },
      workspace = {
        checkThirdParty = false,
        library = lua_library,
      },
    },
  },
})

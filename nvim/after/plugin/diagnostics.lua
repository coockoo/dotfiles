local namespace = vim.api.nvim_create_namespace('ns/eslint')

---@class Args
---@field buf integer

local group = vim.api.nvim_create_augroup('eslint', { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufWritePost" }, {
  group = group,
  ---@param args Args
  callback = function (args)
    local filetype = vim.bo.filetype
    if not vim.tbl_contains({ 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }, filetype) then
      return
    end
    local bufnr = args.buf
    local filename = vim.api.nvim_buf_get_name(bufnr)

    ---@param message string
    local function critical_error(message)
      vim.diagnostic.set(namespace, bufnr, {
        { lnum = 0, col = 0, severity = vim.diagnostic.severity.ERROR, message = message }
      })
    end

    local eslint_success, eslint_res = pcall(function ()
      return vim.system({ 'eslint_d', filename, '--format', 'json' }, { text = true }):wait()
    end)
    if not eslint_success then
      return critical_error("failed to execute eslint_d")
    end

    local parse_success, parse_res = pcall(vim.json.decode, eslint_res.stdout)
    if not parse_success then
      return critical_error(parse_res.stdout)
    end

    local diagnostics = {}
    for _, message in ipairs(parse_res[1].messages) do
      table.insert(diagnostics, {
        lnum = message.line - 1,
        end_num = message.endLine - 1,
        col = message.column - 1,
        end_col = message.endColumn -1,
        severity = message.severity == 1 and vim.diagnostic.severity.WARN or vim.diagnostic.severity.ERROR,
        message = message.message,
        code = message.ruleId,
      })
    end
    vim.diagnostic.set(namespace, bufnr, diagnostics)
  end
})

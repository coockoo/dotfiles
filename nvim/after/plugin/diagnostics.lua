local namespace = vim.api.nvim_create_namespace('ns/eslint')

local group = vim.api.nvim_create_augroup('eslint', { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufWritePost" }, {
  group = group,
  callback = function (args)
    local filetype = vim.bo.filetype
    if not vim.tbl_contains({ 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }, filetype) then
      return
    end
    local bufnr = args.buf
    local filename = vim.api.nvim_buf_get_name(bufnr)
    -- todo: add pcall here too
    local eslint_res = vim.system({ 'eslint_d', filename, '--format', 'json' }, { text = true }):wait()
    local parse_success, parse_res = pcall(vim.json.decode, eslint_res.stdout)
    local diagnostics = {}
    if not parse_success then
      table.insert(diagnostics, {
        lnum = 0,
        col = 0,
        severity = vim.diagnostic.severity.ERROR,
        message = eslint_res.stdout,
      })
    else
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
    end
    vim.diagnostic.set(namespace, bufnr, diagnostics)
  end
})

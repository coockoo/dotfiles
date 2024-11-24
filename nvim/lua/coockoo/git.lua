--- @param str string
local function get_dirname(str)
  return str:match('(.*/)')
end

-- todo: handle non-committed lines
-- todo: handle non-git files
-- todo: handle non-pushed files in origin

local function github_open()
  local filename = vim.api.nvim_buf_get_name(0)
  local dirname = get_dirname(filename)

  local hash_process = vim.system({ 'git', 'rev-parse', 'HEAD' }, { text = true })
  local origin_process = vim.system({ 'git', 'config', '--get', 'remote.origin.url' }, { text = true })
  local root_process = vim.system({ 'git', '-C', dirname, 'rev-parse', '--show-toplevel' }, { text = true })

  local hash = hash_process:wait().stdout:gsub('%s+', '')
  if #hash ~= 40 then
    -- TODO: hanle error somehow (show notification?)
    return
  end

  local origin = origin_process:wait().stdout:gsub('%s+', '')
  local host_and_path = origin:sub(origin:find('@') + 1, -5):gsub(':', '/')

  local root = root_process:wait().stdout:gsub('%s+', '')
  local path = filename:sub(#root + 1, -1)

  local line_number = vim.api.nvim_win_get_cursor(0)[1]

  local url = 'https://' .. host_and_path .. '/blob/' .. hash .. path .. '#L' .. line_number
  vim.ui.open(url)
end

return {
  github_open = github_open,
}

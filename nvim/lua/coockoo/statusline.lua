local lsp_progress = require('coockoo.lsp-progress')
local function status_line()
  local mode = '%-2{%v:lua.string.upper(v:lua.vim.fn.mode())%}'
  local filename = "%{expand('%:~:.')}"
  local filetype = '%y'
  local right_side = '%='
  local git_info = '%{FugitiveStatusline()}'
  local col = '%c'
  local progress = '%{v:lua.require(\'coockoo.lsp-progress\').get_status()}'
  return string.format(
    '%s %s %s %s %s%s %s',
    mode, filename, filetype, col, right_side, progress, git_info
  )
end

lsp_progress.setup()
vim.opt.statusline = status_line()

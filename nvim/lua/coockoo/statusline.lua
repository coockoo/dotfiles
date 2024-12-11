local function status_line()
  local mode = '%-2{%v:lua.string.upper(v:lua.vim.fn.mode())%}'
  local filename = "%{expand('%:~:.')}"
  local filetype = '%y'
  local right_side = '%='
  local git_info = '%{FugitiveStatusline()}'
  local col = '%c'
  return string.format(
    '%s %s %s %s %s%s',
    mode, filename, filetype, col, right_side, git_info
  )
end

vim.opt.statusline = status_line()

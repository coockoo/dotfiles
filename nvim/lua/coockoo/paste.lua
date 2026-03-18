-- This makes Cmd+V remove linebreaks for insert
vim.paste = (function(overridden)
  ---@param lines string[]
  return function(lines, phase)
    if lines[#lines] == '' then
      table.remove(lines)
    end
    return overridden(lines, phase)
  end
end)(vim.paste)

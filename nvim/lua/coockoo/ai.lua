local url = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent'

-- @param input string
local function prompt(input)
  local sys_result = vim.system({
    'curl',
    '-H', 'Content-Type: application/json',
    '-H', 'X-goog-api-key: ' .. vim.env.GEMINI_API_KEY,
    '-s',
    '-X', 'POST',
    '-d', '{"contents":[{"parts":[{"text":"' .. input .. '"}]}]}',
    url,
  }, { text = true }):wait()
  if sys_result.code ~= 0 then
    vim.notify('Error: ' .. sys_result.stderr, vim.log.levels.ERROR)
    return ''
  end
  local res = vim.fn.json_decode(sys_result.stdout)
  local text = res.candidates[1].content.parts[1].text
  text = vim.fn.trim(text)
  return text
end

local function doStuff()
  local mode = vim.api.nvim_get_mode().mode
  if mode == 'normal' then
    vim.notify('Please run this command in normal mode.', vim.log.levels.WARN)
    return
  end
end

return {
  prompt = prompt,
}

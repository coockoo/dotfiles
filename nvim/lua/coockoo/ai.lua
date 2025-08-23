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

local function get_visual_selected_text()
  local start_pos = vim.fn.getpos('v')
  local end_pos = vim.fn.getpos('.')
  if start_pos[2] > end_pos[2] or (start_pos[2] == end_pos[2] and start_pos[3] > end_pos[3]) then
    start_pos, end_pos = end_pos, start_pos
  end
  return table.concat(
    vim.api.nvim_buf_get_text(0, start_pos[2] - 1, start_pos[3] - 1, end_pos[2] - 1, end_pos[3], {}),
    '\n'
  )
end

local function run_ai()
  local input = get_visual_selected_text()
  local output = vim.fn.split(prompt(input), '\n')
  vim.api.nvim_input('<Esc>')
  vim.api.nvim_put(output, 'l', true, true)
end

return {
  prompt = prompt,
  run_ai = run_ai,
}

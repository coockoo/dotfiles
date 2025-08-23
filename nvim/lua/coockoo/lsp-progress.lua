--- @type table<string, string>
local statuses = {}

local function handle_lsp_progress(ev)
  local client_id = ev.data.client_id
  --- @type lsp.ProgressParams
  local params = ev.data.params
  local client = vim.lsp.get_client_by_id(client_id)
  if not client then
    return
  end
  if params.value.kind == 'begin' then
    statuses[client_id] = client.name .. ': 0/0 (0%)'
    return
  end
  if params.value.kind == 'end' then
    statuses[client_id] = ''
    return
  end
  if params.value.kind == 'report' then
    statuses[client_id] = client.name .. ': ' .. params.value.message .. ' (' .. params.value.percentage .. '%)'
    return
  end
end

local function setup()
  vim.api.nvim_create_autocmd('LspProgress', { callback = handle_lsp_progress })
end

local function get_status()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  for _, client in ipairs(clients) do
    local client_id = client.id
    if client.capabilities.window.workDoneProgress and statuses[client_id] and #statuses[client_id] > 0 then
      return statuses[client_id]
    end
  end
  return ''
end

return {
  setup = setup,
  get_status = get_status,
}

local root = ''

---@class Options
---@field root string|nil

local function open_today()
  local year = os.date('%Y')
  local mon = os.date('%m-%b')
  local filename = os.date('%Y-%m-%d-%A.md')
  local dir = root .. '/' .. year .. '/' .. mon
  local path = dir .. '/' .. filename
  os.execute('mkdir -p ' .. dir)
  vim.cmd.edit(path)
end

--- @param options Options
local function setup(options)
  assert(options.root, 'root should be set up')
  assert(#options.root > 0, 'root should be non-empty')

  root = options.root
end

setup({ root = os.getenv('NOTES_ROOT') })
vim.keymap.set('n', '<leader>dt', open_today)

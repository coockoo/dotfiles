---@params node TSNode
local function handle_link_destination(node)
  local buffer = vim.api.nvim_get_current_buf()
  local uri = vim.treesitter.get_node_text(node, buffer)
  vim.ui.open(uri)
end

---@params node TSNode
local function handle_link_label(node)
  local buffer = vim.api.nvim_get_current_buf()
  local label = vim.treesitter.get_node_text(node, buffer)
  local query = vim.treesitter.query.parse('markdown', [[
    (link_reference_definition
      (link_label) @label (#eq? @label "]] .. label .. [[")
      (link_destination) @link_destination)
    ]]
  )

  local tree = vim.treesitter.get_parser():parse()
  if not tree or #tree == 0 then
    return
  end
  local root = tree[1]:root()

  for _, match, _ in query:iter_matches(root, 0) do
    ---@type TSNode
    local link_node
    if type(match[2]) == 'table' then
      link_node = match[2][1]
    else
      link_node = match[2]
    end

    if link_node and link_node:type() == 'link_destination' then
      return handle_link_destination(link_node)
    end
  end
end

---@params node TSNode
local function handle_link_text(node)
  local next = node:next_named_sibling()
  if not next then
    return
  end
  if next:type() == 'link_destination' then
    return handle_link_destination(next)
  end
  if next:type() == 'link_label' then
    return handle_link_label(next)
  end
end

---@params node TSNode
local function handle_inline_link(node)
  for child in node:iter_children() do
    if child:type() == 'link_destination' then
      return handle_link_destination(child)
    end
    if child:type() == 'link_label' then
      return handle_link_label(child)
    end
  end
end


local function open_link()
  local node = vim.treesitter.get_node()
  if not node then
    return
  end

  if node:type() == 'link_destination' then
    return handle_link_destination(node)
  end

  if node:type() == 'link_text' then
    return handle_link_text(node)
  end

  if node:type() == 'link_label' then
    return handle_link_label(node)
  end

  if node:type() == 'inline_link' then
    return handle_inline_link(node)
  end

  if node:type() == 'full_reference_link' then
    -- split into 2 if this causes issues, currently implementation is the same
    return handle_inline_link(node)
  end

  if node:type() == 'inline' then
    local uri = vim.fn.expand('<cWORD>')
    return vim.ui.open(uri)
  end
end

return {
  open_link = open_link,
}

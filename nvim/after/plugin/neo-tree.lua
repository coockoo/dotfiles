require("neo-tree").setup {
  close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
  window = {
    position = 'float',
    mappings = {
      ["<Esc>"] = "close_window",
    },
  },
  filesystem = {
    follow_current_file = true,
    hijack_netrw_behavior = 'open_default',
    reveal = true,
  },
  default_component_configs = {
    indent = {
      indent_size = 1,
      padding = 0,
    },
    icon = {
      folder_closed = '+',
      folder_open = '-',
    }
  }
}
-- open netrw
vim.keymap.set("n", "<leader>t", function() vim.cmd('Neotree reveal') end)

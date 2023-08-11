local builtin = require('telescope.builtin')
local actions = require("telescope.actions")

vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-o>', builtin.git_files, {})
vim.keymap.set('n', '<C-i>', builtin.buffers, {})
vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    },
    layout_config = {
      horizontal = {
        height = 0.6,
        preview_cutoff = 120,
        prompt_position = "top",
        width = 0.8
      },
    },
    sorting_strategy = "ascending",
  },
  pickers = {
    find_files = {
      disable_devicons = true
    }
  },
}

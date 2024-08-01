local builtin = require('telescope.builtin')
local actions = require("telescope.actions")

vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Open telescope all files' })
vim.keymap.set('n', '<C-o>', builtin.git_files, { desc = 'Open telescope git files' })
vim.keymap.set('n', '<C-b>', builtin.buffers, { desc = 'Open telescope buffers' })
vim.keymap.set('n', '<C-g>', builtin.live_grep, { desc = 'Open telescope live grep' })
vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<Esc>"] = actions.close,
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
    color_devicons = false
  },
  pickers = {
    git_files = {
      use_git_root = false,
      show_untracked = true
    }
  },
}

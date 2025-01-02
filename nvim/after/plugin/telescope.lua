local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'telescope: [p]roject files' })
vim.keymap.set('n', '<C-o>', builtin.git_files, { desc = 'telescope: [o]pen git files' })
vim.keymap.set('n', '<C-b>', builtin.buffers, { desc = 'telescope: [b]uffers' })
vim.keymap.set('n', '<C-g>', builtin.live_grep, { desc = 'telescope: live [g]rep' })
vim.keymap.set('n', '<leader>r', builtin.resume, { desc = 'telescope: [r]esume' })
vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = 'telescope: [g]o to [r]eferences' })

require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ['<Esc>'] = actions.close,
      },
    },
    layout_config = {
      horizontal = {
        height = 0.6,
        preview_cutoff = 120,
        prompt_position = 'top',
        width = 0.8,
      },
    },
    sorting_strategy = 'ascending',
    color_devicons = false,
  },
  pickers = {
    git_files = {
      use_git_root = false,
      show_untracked = true,
    },
  },
})

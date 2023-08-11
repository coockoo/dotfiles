local mark = require('harpoon.mark')
local ui = require('harpoon.ui')
local harpoon = require('harpoon')

harpoon.setup({
  tabline = true,
})

vim.keymap.set('n', '<leader>a', mark.add_file)
vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu)

vim.keymap.set('n', '<C-j>', function() ui.nav_file(1) end)
vim.keymap.set('n', '<C-k>', function() ui.nav_file(2) end)
vim.keymap.set('n', '<C-l>', function() ui.nav_file(3) end)
vim.keymap.set('n', '<C-;>', function() ui.nav_file(4) end)
vim.keymap.set('n', 'gt', ui.nav_next)
vim.keymap.set('n', 'gT', ui.nav_prev)

vim.api.nvim_set_hl(0, 'HarpoonInactive', { link = 'Tabline' })
vim.api.nvim_set_hl(0, 'HarpoonActive', { link = 'TablineSel' })
vim.api.nvim_set_hl(0, 'HarpoonNumberActive', { link = 'TablineSel' })
vim.api.nvim_set_hl(0, 'HarpoonNumberInactive', { link = 'Tabline' })

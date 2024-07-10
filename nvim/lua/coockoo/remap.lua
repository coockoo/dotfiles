-- move lines in visual mode
vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<C-k>', ":m '<-2<CR>gv=gv")

-- join keeps cursor in place
vim.keymap.set('n', 'J', 'mzJ`z')

-- when jumping keep cursor in the middle
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

-- replace in visual mode, but keep register
vim.keymap.set('x', '<leader>p', '"_dP')

-- make <leader>y to work with system clipboard
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')

-- yank a file into system clipboard
vim.keymap.set('n', '<leader>yf', 'mzggVG"+y`z', { desc = 'yank a file into system clipboard' })

-- delete into black hole
vim.keymap.set('n', '<leader>d', '"_d', { desc = 'delete into black hole' })
vim.keymap.set('v', '<leader>d', '"_d', { desc = 'delete into black hole' })

-- please, no global Q
vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', 'q:', '<nop>')

-- in normal mode while on word, replace it in file via %s
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = 'replace word under cursor' })

-- make file executable (chmod +x)
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

-- git checkout current changes in current file
vim.keymap.set('n', '<leader>gco', '<cmd>Git checkout -- %<CR>', { silent = true })
-- git add
vim.keymap.set('n', '<leader>ga', '<cmd>Git add %<CR>', { silent = true })

-- leave only split
vim.keymap.set('n', '<leader>o', '<C-w>o')

-- only for work setup (annoying)
vim.keymap.set('n', '<leader>lf', '<cmd>!yarn lint --fix %<CR><CR>')

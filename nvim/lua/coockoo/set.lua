vim.opt.guicursor = 'a:-blinkwait175-blinkoff150-blinkon175'

vim.opt.number = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.syntax = 'on'

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 50
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0

vim.opt.colorcolumn = '120'

vim.g.mapleader = ' '

vim.opt.encoding = 'utf-8'

vim.opt.showmode = false

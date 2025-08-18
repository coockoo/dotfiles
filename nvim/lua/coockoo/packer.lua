vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use {
    'nvim-telescope/telescope.nvim', branch = 'master',
    requires = { { 'nvim-lua/plenary.nvim' } },
  }
  use {
    'nvim-treesitter/nvim-treesitter', branch = 'master', -- i'd gladly migrate to main, but it is broken
    run = ':TSUpdate',
  }
  use 'mbbill/undotree'
  use 'tpope/vim-fugitive'

  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  use 'neovim/nvim-lspconfig'

  use { 'williamboman/mason.nvim', run = ':MasonUpdate' }
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'

  use 'mhartington/oceanic-next'

  use {
    'ThePrimeagen/harpoon',
    requires = { 'nvim-lua/plenary.nvim' },
  }
  use {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    requires = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
  }

  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && npm install',
    setup = function() vim.g.mkdp_filetypes = { 'markdown' } end,
    ft = { 'markdown' },
  }

  use {
    'airblade/vim-gitgutter',
    branch = 'main',
  }

  use 'github/copilot.vim'
end)

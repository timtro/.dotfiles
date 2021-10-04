return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Editor/IDE tools
  use 'kyazdani42/nvim-web-devicons'
  use 'akinsho/nvim-toggleterm.lua'
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  use {
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'}
  }
  use 'machakann/vim-highlightedyank'
  use 'kevinhwang91/rnvimr'
  use 'AndrewRadev/sideways.vim'
  -- use 'Konfekt/FastFold'
  use 'matze/vim-move'

  -- movement, buffer-search, formatting and lsp
  use 'andymass/vim-matchup'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-commentary'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'easymotion/vim-easymotion'

  -- IDE / LSP / completion
  use 'neovim/nvim-lspconfig'
  use 'tamago324/nlsp-settings.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'kabouzeid/nvim-lspinstall'
  use 'folke/lsp-colors.nvim'
  use 'folke/trouble.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/nvim-cmp'
    -- Icons for autocompletion. Configured in lsp.lua:
  use 'onsails/lspkind-nvim'
  -- use 'svermeulen/vim-easyclip'

  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'nvim-treesitter/nvim-treesitter-refactor',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    run = ':TSUpdate',
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'}
  }

  use 'p00f/nvim-ts-rainbow'
  use 'sheerun/vim-polyglot'
  use 'norcalli/nvim-colorizer.lua'
  use 'jackguo380/vim-lsp-cxx-highlight'

  -- colorschemes
  use 'tjdevries/colorbuddy.vim'
  use 'dracula/vim'
  use 'marko-cerovac/material.nvim'
  use 'Th3Whit3Wolf/onebuddy'
  use 'Yagua/nebulous.nvim'
  use 'rakr/vim-one'
  use 'lifepillar/vim-gruvbox8'
  use 'folke/tokyonight.nvim'
  use 'projekt0n/github-nvim-theme'
  use 'logico/typewriter-vim'

  -- ft
  use 'lervag/vimtex'
  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install',
    cmd = 'MarkdownPreview'
  }
  use 'sbdchd/neoformat'
  use 'tikhomirov/vim-glsl'
end)

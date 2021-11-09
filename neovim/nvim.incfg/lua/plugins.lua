return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'

  -- Editor/IDE tools {{{
  use 'kyazdani42/nvim-web-devicons'
  use 'akinsho/nvim-toggleterm.lua'
  use 'glepnir/dashboard-nvim'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-tree').setup {}
    end,
  }
  use {
    'hoob3rt/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }
  use {
    'romgrk/barbar.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }
  use 'machakann/vim-highlightedyank'
  use {
    -- For minimap.vim, don't forget to `cargo install --locked code-minimap`
    'wfxr/minimap.vim',
    config = function()
      vim.g.minimap_git_colors = true
      vim.g.minimap_highlight_search = true
    end,
  }
  use 'kevinhwang91/rnvimr'
  use 'AndrewRadev/sideways.vim'
  -- use 'Konfekt/FastFold'
  use 'matze/vim-move'
  use 'tversteeg/registers.nvim'
  -- Shade inactive splits:
  -- use 'sunjon/shade.nvim'
  use 'xiyaowong/nvim-transparent'
  use {
    'folke/twilight.nvim',
    config = function()
      require('twilight').setup {}
    end,
  }
  use {
    'folke/zen-mode.nvim',
    config = function()
      require('zen-mode').setup {}
    end,
  }
  use {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
  }
  use 'sbdchd/neoformat'

  -- movement, buffer-search, formatting and lsp
  use 'andymass/vim-matchup'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-commentary'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'easymotion/vim-easymotion'

  -- }}}

  -- IDE / LSP / completion {{{
  use 'neovim/nvim-lspconfig'
  use 'tamago324/nlsp-settings.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'kabouzeid/nvim-lspinstall'
  use 'folke/lsp-colors.nvim'
  use 'folke/trouble.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } },
  }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  use 'ray-x/lsp_signature.nvim'
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

  -- NOTE: For debugging treesitter
  use 'nvim-treesitter/playground'

  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
  }

  use 'p00f/nvim-ts-rainbow'
  use 'norcalli/nvim-colorizer.lua'
  use 'KabbAmine/vCoolor.vim'
  use 'jackguo380/vim-lsp-cxx-highlight'

  -- colorschemes
  use 'tjdevries/colorbuddy.vim'
  use 'dracula/vim'
  use 'marko-cerovac/material.nvim'
  use 'Th3Whit3Wolf/onebuddy'
  -- use 'rakr/vim-one'
  use 'joshdick/onedark.vim'
  use 'lifepillar/vim-gruvbox8'
  use 'folke/tokyonight.nvim'
  use 'projekt0n/github-nvim-theme'
  use 'logico/typewriter-vim'
  use 'widatama/vim-phoenix'
  use 'pineapplegiant/spaceduck'
  use 'drewtempelmeyer/palenight.vim'
  use 'FrenzyExists/aquarium-vim'
  -- }}}

  -- Notes and Productivity {{{
  use {
    'lervag/wiki.vim',
    config = function()
      vim.g.wiki_root = '~/Documents/wiki'
    end,
  }
  -- }}} (Notes and Productivity)

  -- Filetype and syntax plugins. {{{
  -- -- Org
  use 'kristijanhusak/orgmode.nvim'

  use 'dhruvasagar/vim-table-mode'
  use 'michaelb/sniprun'
  use {
    'lukas-reineke/headlines.nvim',
    config = function()
      require('headlines').setup()
    end,
  }
  use {
    'akinsho/org-bullets.nvim',
    config = function()
      require('org-bullets').setup {
        symbols = { '◉', '○', '✸', '✿' },
      }
    end,
  }

  -- -- (La)TeX
  use 'lervag/vimtex'
  use 'jbyuki/nabla.nvim' -- pretty print/ASCII artify LaTeX math.
  -- -- Markdown
  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install',
    cmd = 'MarkdownPreview',
  }
  -- -- glsl
  use 'tikhomirov/vim-glsl'
  use { 'timtro/glslView-nvim', ft = 'glsl' }
  -- -- Rust
  use 'simrat39/rust-tools.nvim'

  -- Neo/vim plugin development
  use 'tpope/vim-scriptease'
  use 'folke/lua-dev.nvim'
  use 'rafcamlet/nvim-luapad'
  use 'rcarriga/nvim-notify'
  use 'nvim-lua/plenary.nvim'

  -- wiki
  use 'lervag/wiki-ft.vim'

  -- }}}
end)

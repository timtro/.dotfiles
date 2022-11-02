-- vim: fdm=marker:fdc=1

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Editor/IDE tools {{{
  use 'kyazdani42/nvim-web-devicons'
  use 'akinsho/toggleterm.nvim'
  use {
    'glepnir/dashboard-nvim',
    config = [[ require 'config.dashboard' ]],
  }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup {}
    end,
  }
  use {
    'hoob3rt/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }
  use { -- Tabs
    'romgrk/barbar.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }
  use {
    'machakann/vim-highlightedyank',
    config = function()
      vim.g.highlightedyank_highlight_duration = 200
    end,
  }
  use 'kevinhwang91/rnvimr'
  use 'AndrewRadev/sideways.vim'
  use 'matze/vim-move' -- Block/line move.
  --                       NOTE: this maps <A-h>, <A-j>, <A-k>, <A-l>
  use 'xiyaowong/nvim-transparent'
  use 'folke/twilight.nvim'

  use {
    'folke/zen-mode.nvim',
    config = function()
      require('zen-mode').setup {}
    end,
  }
  use {
    'folke/todo-comments.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = [[require 'config.todo-comments']],
  }
  use { 'tversteeg/registers.nvim', config = [[require 'config.registers']] }
  use 'mbbill/undotree'
  use 'andymass/vim-matchup'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-fugitive'
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = [[require 'config.indent-blankline']],
  }
  use 'editorconfig/editorconfig-vim' -- https://editorconfig.org/
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  }
  use 'KabbAmine/vCoolor.vim'
  use 'p00f/nvim-ts-rainbow'

  -- -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = [[ require 'config.telescope' ]],
  }
  use {
    'nvim-telescope/telescope-project.nvim',
    config = function()
      require('telescope').load_extension 'project'
    end,
  }
  use {
    'nvim-telescope/telescope-bibtex.nvim',
    config = function()
      require('telescope').load_extension 'bibtex'
    end,
    requires = { 'nvim-telescope/telescope.nvim' },
  }

  -- Rapid movement plugin(s)
  use {
    'ggandor/lightspeed.nvim',
    requires = { 'tpope/vim-repeat' },
    config = function()
      require('lightspeed').setup {}
    end,
  }

  -- TODO: Remove once https://github.com/neovim/neovim/issues/12587 is fixed.
  use 'antoinemadec/FixCursorHold.nvim'

  -- For prose:
  use 'dbmrq/vim-redacted' -- To blank out blocks of text.
  use 'dbmrq/vim-chalk' -- Auto number nested fold markers.
  -- }}}

  -- LSP / completion / formatting / snipits {{{
  use {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
  }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      {
        'hrsh7th/cmp-nvim-lsp',
        after = 'nvim-cmp',
        requires = 'neovim/nvim-lspconfig',
      },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-omni', after = 'nvim-cmp', ft = 'tex' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
      { 'quangnguyen30192/cmp-nvim-ultisnips', after = 'nvim-cmp' },
    },
  }
  use 'tamago324/nlsp-settings.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'
  use { 'folke/lsp-colors.nvim', config = [[require 'config.lsp-colors']] }
  use 'folke/trouble.nvim'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  -- use 'hrsh7th/cmp-vsnip'
  use {
    'L3MON4D3/LuaSnip',
    after = 'nvim-cmp',
    config = [[require 'config.luasnip']],
  }
  use { 'saadparwaiz1/cmp_luasnip' }
  use 'ray-x/lsp_signature.nvim'
  use 'onsails/lspkind-nvim' -- Icons for autocompletion. Configured in lsp.lua:
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = [[require 'config.treesitter']],
  }
  use {
    'nvim-treesitter/nvim-treesitter-refactor',
    requires = 'nvim-treesitter/nvim-treesitter',
  }
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    requires = 'nvim-treesitter/nvim-treesitter',
  }
  -- NOTE: For debugging treesitter
  use 'nvim-treesitter/playground'
  --
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = [[require 'config.gitsigns']],
  }
  use 'sbdchd/neoformat'
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  }
  -- }}}

  -- Probation {{{
  -- Spellchecking in code using treeistter.
  use {
    'lewis6991/spellsitter.nvim',
    config = function()
      require('spellsitter').setup {
        enable = { 'tex', 'md' },
        spellchecker = 'vimfn',
      }
    end,
  }
  use 'mfussenegger/nvim-treehopper'
  use {
    'kevinhwang91/nvim-hlslens',
    config = function()
      require('hlslens').setup()
    end,
  }
  -- use 'SidOfc/mkdx'

  -- }}}

  -- Notes and Productivity {{{
  use {
    'lervag/wiki.vim',
    config = function()
      vim.g.wiki_root = '~/Documents/wiki'
      vim.g.wiki_filetypes = { 'md' }
      vim.g.wiki_link_extension = '.md'
      vim.g.wiki_link_target_type = 'md'
    end,
  }
  use {
    'lervag/wiki-ft.vim',
    requires = { 'lervag/wiki-ft.vim' },
  }
  use {
    'lukas-reineke/headlines.nvim',
    config = function()
      require('headlines').setup()
    end,
  }
  use {
    'dkarter/bullets.vim',
    config = function()
      vim.g.bullets_checkbox_markers = '✗○◐●✓'
    end,
  }
  -- }}} (Notes and Productivity)

  -- Filetype and syntax plugins {{{
  -- -- General/Text/Prose
  use 'dhruvasagar/vim-table-mode'

  -- -- (La)TeX
  use { 'lervag/vimtex', config = [[require 'config.vimtex']] }

  -- -- Markdown
  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install',
  }

  -- -- glsl
  use { 'timtro/glslView-nvim', ft = 'glsl' }

  -- -- Rust
  use 'simrat39/rust-tools.nvim'

  -- Neo/vim plugin development
  use 'tpope/vim-scriptease'
  -- use 'folke/lua-dev.nvim'
  use 'rafcamlet/nvim-luapad'
  use 'rcarriga/nvim-notify'
  use 'nvim-lua/plenary.nvim'

  -- -- C++
  use 'jackguo380/vim-lsp-cxx-highlight'
  -- }}}

  -- Colorschemes {{{
  use 'tjdevries/colorbuddy.vim'
  use 'marko-cerovac/material.nvim'
  use 'joshdick/onedark.vim'
  use 'folke/tokyonight.nvim'
  use 'lifepillar/vim-gruvbox8'
  use 'ellisonleao/gruvbox.nvim'
  use 'logico/typewriter-vim'
  use 'widatama/vim-phoenix'
  use 'pineapplegiant/spaceduck'
  use 'drewtempelmeyer/palenight.vim'
  use 'EdenEast/nightfox.nvim'
  use 'sainnhe/sonokai'
  use 'yonlu/omni.vim'
  use 'RRethy/nvim-base16'
  use 'shaunsingh/moonlight.nvim'
  use 'sainnhe/gruvbox-material'
  use 'yashguptaz/calvera-dark.nvim'
  use 'kdheepak/monochrome.nvim'
  use 'savq/melange'
  -- }}}
end)

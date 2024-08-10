return {
  -- Editor/IDE tools {{{
  -- 'nvim-tree/nvim-web-devicons',
  'nvim-tree/nvim-web-devicons',
  { 'akinsho/toggleterm.nvim', config = function() require 'config.toggleterm' end },
  {
    'hoob3rt/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  -- { -- Tabs / top tab bar
  --   'romgrk/barbar.nvim',
  --   dependencies = { 'nvim-tree/nvim-web-devicons' },
  --   config = function() require 'config.barbar' end,
  -- }
  {
    'machakann/vim-highlightedyank',
    config = function()
      vim.g.highlightedyank_highlight_duration = 200
    end,
  },
  {
    'kevinhwang91/rnvimr',
    config = function()
      vim.g.rnvimr_draw_border = 1
    end,
  },
  'AndrewRadev/sideways.vim',
  'matze/vim-move', -- Block/line move.
  --                       NOTE: this maps <A-h>, <A-j>, <A-k>, <A-l>
  { 'xiyaowong/nvim-transparent', config = function() require 'config.transparent' end },
  { 'folke/twilight.nvim', config = function() require 'config.twilight' end },
  {
    'folke/zen-mode.nvim',
    config = function()
      require('zen-mode').setup {}
    end,
  },
  { 'tversteeg/registers.nvim', config = function() require 'config.registers' end },
  'mbbill/undotree',
  'andymass/vim-matchup',
  'tpope/vim-surround',
  'tpope/vim-repeat',
  'tpope/vim-fugitive',
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function() require 'config.indent-blankline' end,
  },
  'editorconfig/editorconfig-vim', -- https://editorconfig.org/
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  },
  {
    'ziontee113/color-picker.nvim',
    config = function() require('color-picker').setup({}) end,
  },

  -- -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-bibtex.nvim',
    },
    config = function() require 'config.telescope.init' end,
  },
  {
    'nvim-telescope/telescope-project.nvim',
    -- config = function()
    --   require('telescope').load_extension 'project'
    -- end,
  },
  {
    'nvim-telescope/telescope-bibtex.nvim',
    -- config = function()
    --   require('telescope').load_extension 'bibtex'
    -- end,
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },

  -- Rapid movement plugin (like easymotion)
  {
    'ggandor/leap.nvim',
    dependencies = { 'tpope/vim-repeat' },
    config = function()
      require('leap').add_default_mappings()
    end,
  },

  -- For prose:
  'dbmrq/vim-redacted', -- To blank out blocks of text.
  -- Auto number nested fold markers.
  { 'dbmrq/vim-chalk', config = function() require 'config.foldmarkers' end },
  -- }}}

  -- LSP / completion / formatting / snipits {{{
  { 'folke/lsp-colors.nvim', config = function() require 'config.lsp-colors' end },
  'folke/trouble.nvim',
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function() require 'config.treesitter' end,
  },
  {
    'nvim-treesitter/nvim-treesitter-refactor',
    dependencies = 'nvim-treesitter/nvim-treesitter',
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = 'nvim-treesitter/nvim-treesitter',
  },
  -- NOTE: For debugging treesitter
  {
    'nvim-treesitter/playground',
    config = function() require 'config.ts-playground' end,
  },
  --
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function() require 'config.gitsigns' end,
  },
  'sbdchd/neoformat',
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },
  -- }}}

  -- Probation {{{
  'mfussenegger/nvim-treehopper',
  {
    'kevinhwang91/nvim-hlslens',
    config = function()
      require('hlslens').setup()
    end,
  },
  -- 'SidOfc/mkdx'

  -- }}}

  -- Notes and Productivity {{{
  {
    'lervag/wiki.vim',
    config = function()
      vim.g.wiki_root = '~/Documents/wiki'
      vim.g.wiki_filetypes = { 'md' }
      vim.g.wiki_link_extension = '.md'
      vim.g.wiki_link_target_type = 'md'
    end,
  },
  -- {
  --   'nvim-neorg/neorg',
  --   config = function() require 'config.neorg' end,
  --   run = ':Neorg sync-parsers',
  --   dependencies = 'nvim-lua/plenary.nvim',
  -- },
  {
    'lervag/wiki-ft.vim',
    dependencies = { 'lervag/wiki-ft.vim' },
  },
  -- { -- hilight heading lines
  --   'lukas-reineke/headlines.nvim',
  --   config = function()
  --     require('headlines').setup()
  --   end,
  -- }
  -- {
  --   'dkarter/bullets.vim',
  --   config = function()
  --     vim.g.bullets_checkbox_markers = '✗○◐●✓'
  --   end,
  -- }
  -- }}} (Notes and Productivity)

  -- Filetype and syntax plugins {{{
  -- -- General/Text/Prose
  -- 'dhruvasagar/vim-table-mode'

  -- -- (La)TeX
  { 'lervag/vimtex', config = function() require 'config.vimtex' end, ft = 'tex' },
  { 'peterbjorgensen/sved', ft = 'tex' }, -- synctex for Evince through DBus.
  -- { 'Konfekt/vim-latexencode' }
  { 'timtro/vim-latexencode', branch = 'feat(visual-select)' },

  -- -- Markdown
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && yarn install',
    ft = 'markdown'
  },

  -- -- glsl
  { 'timtro/glslView-nvim', ft = 'glsl' },

  -- Neo/vim plugin development
  'tpope/vim-scriptease',
  -- 'folke/lua-dev.nvim'
  { 'rcarriga/nvim-notify', config = function() require 'config.notify' end },
  'nvim-lua/plenary.nvim',

  -- -- C++
  'jackguo380/vim-lsp-cxx-highlight',

  -- -- Haskell
  {
    'MrcJkb/haskell-tools.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function() require 'config.haskell-tools' end,
    ft = { 'haskell' },
  },
  -- }}}

  -- Colorschemes {{{
  {'folke/tokyonight.nvim', lazy = false, priority = 10000},
  {'tjdevries/colorbuddy.vim', lazy = true},
  {'marko-cerovac/material.nvim', lazy = true},
  {'joshdick/onedark.vim', lazy = true},
  {'lifepillar/vim-gruvbox8', lazy = true},
  {'ellisonleao/gruvbox.nvim', lazy = true},
  {'logico/typewriter-vim', lazy = true},
  {'widatama/vim-phoenix', lazy = true},
  {'pineapplegiant/spaceduck', lazy = true},
  {'drewtempelmeyer/palenight.vim', lazy = true},
  {'EdenEast/nightfox.nvim', lazy = true},
  {'sainnhe/sonokai', lazy = true},
  {'yonlu/omni.vim', lazy = true},
  {'RRethy/nvim-base16', lazy = true},
  {'shaunsingh/moonlight.nvim', lazy = true},
  {'sainnhe/gruvbox-material', lazy = true},
  {'yashguptaz/calvera-dark.nvim', lazy = true},
  {'kdheepak/monochrome.nvim', lazy = true},
  {'savq/melange', lazy = true},
  -- }}}
}


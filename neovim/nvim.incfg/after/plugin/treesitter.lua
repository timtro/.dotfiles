require('nvim-treesitter.configs').setup {
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {
    --   '#FFFFFF',
    --   '#666666',
    --   '#FF0000',
    --   '#00FF00',
    --   '#0000FF',
    -- }
    -- termcolors = {} -- table of colour name strings
  },
  matchup = {
    enable = true, -- mandatory, false will disable the whole extension
    disable = {}, -- optional, list of language that will be disabled
  },
  -- }}}
}

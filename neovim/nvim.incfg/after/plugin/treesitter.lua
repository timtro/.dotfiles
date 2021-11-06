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
  -- {{{ org mode
  -- If TS highlights are not enabled at all, or disabled via `disable` prop,
  --   highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    disable = { 'org' }, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    additional_vim_regex_highlighting = { 'org' }, -- Required since TS highlighter doesn't support all syntax features (conceal)
  },
  ensure_installed = { 'org' }, -- Or run :TSUpdate org
  -- }}}
}

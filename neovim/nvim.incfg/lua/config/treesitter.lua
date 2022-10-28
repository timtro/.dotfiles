require('nvim-treesitter.configs').setup {
  ensure_installed = {"lua", "python", "cpp", "latex", "haskell"},
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    disable = function(lang, buf)
        local max_filesize = 10000 * 1024 -- 10 MB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
    additional_vim_regex_highlighting = false,
  },
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
  additional_vim_regex_highlighting = false,
  matchup = {
    enable = true, -- mandatory, false will disable the whole extension
    disable = {}, -- optional, list of language that will be disabled
  },
}

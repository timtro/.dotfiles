local telescope = require 'telescope'

telescope.setup {
  defaults = {
    prompt_prefix = '  ',
    selection_caret = '❯ ',
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
  },
  extensions = {
    bibtex = {
      global_files = {
        '/home/timtro/texmf/bibtex/bib',
      },
      format = 'plain',
    },
    project = {
      base_dirs = {
        { path = '~/workspace', max_depth = 2 },
        { path = '~/Documents/Thesis-PhD', max_depth = 1 },
      },
      hidden_files = false, -- default: false
    },
  },
}

telescope.load_extension 'bibtex'
telescope.load_extension 'session-lens'

local M = {}

function M.grep_wiki()
  local opts = {}
  opts.hidden = true
  opts.search_dirs = {
    '~/Documents/wiki',
  }
  opts.prompt_prefix = ' '
  opts.prompt_title = ' Grep Wiki'
  opts.path_display = { 'smart' }
  require('telescope.builtin').live_grep(opts)
end

return M

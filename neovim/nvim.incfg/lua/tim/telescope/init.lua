require('telescope').setup {
  defaults = {
    prompt_prefix = ' ',
    selection_caret = '❯ ',
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
  },
  extensions = {
    bibtex = {
      global_files = {
        '/home/timtro/texmf/bibtex/bib/library.bib',
        -- '/home/timtro/texmf/bibtex/bib/standards.bib',
        '/home/timtro/texmf/bibtex/bib/web-resources.bib',
        '/home/timtro/texmf/bibtex/bib/mypubs.bib',
      },
    },
  },
}

require('telescope').load_extension 'bibtex'

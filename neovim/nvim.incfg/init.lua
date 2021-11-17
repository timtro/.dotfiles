require 'tim.settings'
require 'packer_bootstrap'

local color_opts = require 'colors.dejour'
color_opts.setup()

require 'tim.statusline'(color_opts.status_theme)
require 'tim.telescope'
require 'tim.plugins'
require 'tim.globals'
require 'tim.mappings'

vim.cmd [[command! -nargs=* -bar -complete=command OutToBuf :enew|pu=execute('<args>')]]

-- Columns 80 and above are imbued with diagnostic colors:
vim.cmd [[:match DiagnosticWarn "\%81v."]]
vim.cmd [[:2match DiagnosticError "\%>81v."]]

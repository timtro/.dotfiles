require 'packer_bootstrap'

require 'tim.settings'
require 'tim.mappings'
require 'tim.plugins'
require 'tim.globals'

local color_opts = require 'colors.dejour'
color_opts.setup()
require 'tim.statusline'(color_opts.status_theme)

vim.cmd [[command! -nargs=* -bar -complete=command OutToBuf :enew|pu=execute('<args>')]]

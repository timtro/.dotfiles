require 'tim.settings'
require 'packer_bootstrap'

local color_opts = require 'colors.dejour'
color_opts.setup()

require 'tim.statusline'(color_opts.status_theme)
require 'tim.telescope'
require 'tim.plugins'
require 'tim.globals'
require 'tim.mappings'

-- TODO: decide where this should go:
vim.cmd [[command! -nargs=* -bar -complete=command OutToBuf :enew|pu=execute('<args>')]]

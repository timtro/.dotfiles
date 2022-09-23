require 'tim.settings'
require 'packer_bootstrap'
require 'tim.plugins'

local is_daylight = function (dt)
  return tonumber(dt.hour) <= 19 and tonumber(dt.hour) >= 8
end

local colours_dejour = function (dt)
  if is_daylight(dt) then
    return 'colors.tokyonight-night'
  else
    -- return 'colors.gruvbox-nvim-dark'
    return 'colors.tokyonight-night'
  end
end

local color_opts = require (colours_dejour(os.date('*t')))
color_opts.setup()

require 'tim.statusline'(color_opts.status_theme)
require 'config/dashboard'
require 'tim.lsp'
require 'tim.completion'
require 'tim.telescope'
require 'tim.globals'
require 'tim.mappings'

-- TODO: decide where this should go:
vim.cmd [[command! -nargs=* -bar -complete=command OutToBuf :enew|pu=execute('<args>')]]

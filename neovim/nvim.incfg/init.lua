require 'tim.settings'
require 'packer_bootstrap'
require 'tim.plugins'

local is_daylight = function(dt)
  return tonumber(dt.hour) <= 19 and tonumber(dt.hour) >= 8
end

local colours_dejour = function(dt)
  if is_daylight(dt) then
    return 'colors.tokyonight-night'
  else
    -- return 'colors.gruvbox-nvim-dark'
    return 'colors.tokyonight-night'
  end
end

local color_opts = require(colours_dejour(os.date '*t'))
color_opts.setup()

require 'tim.statusline'(color_opts.status_theme)
require 'tim.globals'
require 'tim.mappings'
require 'config.telescope'
require 'config.lsp'
require 'config.completion'
require 'config.dashboard'
require 'config.treesitter'

-- TODO: decide where this should go:
vim.cmd [[command! -nargs=* -bar -complete=command OutToBuf :enew|pu=execute('<args>')]]

-- TODO: Rewrite in lua.
vim.cmd [[
function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv
]]

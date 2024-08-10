require 'tim.settings'
require 'tim.lazy'

require 'tim.globals'
require 'tim.mappings'
-- require 'config.cmp-lsp'
require 'tim.bibfetch'

-- Colours                                                                  {{{1
local is_daylight = function(dt)
  return tonumber(dt.hour) <= 19 and tonumber(dt.hour) >= 8
end

local colours_dejour = function(dt)
  if is_daylight(dt) then
    return 'colors.tokyonight-night'
    -- return 'colors.gruvbox-nvim-dark'
  else
    return 'colors.tokyonight-night'
    -- return 'colors.gruvbox-nvim-dark'
  end
end

local color_opts = require(colours_dejour(os.date '*t'))
color_opts.setup()

require 'tim.statusline'(color_opts.status_theme)
--                                                                          }}}1
-- after                                                                    {{{1
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
--                                                                          }}}1

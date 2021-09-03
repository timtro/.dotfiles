vim.opt.background = 'dark'
vim.cmd'colorscheme gruvbox8'

vim.cmd[[
let g:gruvbox_italics = 1
let g:gruvbox_italicize_strings = 1
let g:gruvbox_bold = 1
let g:gruvbox_underline = 1
let g:gruvbox_transp_bg = 0
let g:gruvbox_filetype_hi_groups = 1
let g:gruvbox_plugin_hi_groups = 1
]]

local palette = require 'colors.palettes'

local rainbow_colors =
  { palette.gruv.fg0
  , palette.gruv.blue
  , palette.gruv.purple
  , palette.gruv.yellow
  , palette.gruv.green
  , palette.gruv.orange
  , palette.gruv.dkPurple
  , palette.gruv.dkBlue
  , palette.gruv.dkYellow
  , palette.gruv.dkGreen
  , palette.gruv.dkOrange
  }

vim.cmd(string.format('highlight IndentBlanklineContextChar guifg=%s gui=nocombine cterm=nocombine',
    palette.gruv.blue))

local f = require 'colors.rainbow_setter'
f(rainbow_colors)

return {status_theme = 'gruvbox'}

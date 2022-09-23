
local function setup()
  vim.opt.background = 'dark'
  vim.cmd 'colorscheme gruvbox8'

  vim.cmd [[
  let g:gruvbox_italics = 1
  let g:gruvbox_italicize_strings = 1
  let g:gruvbox_bold = 1
  let g:gruvbox_underline = 1
  let g:gruvbox_transp_bg = 1
  let g:gruvbox_filetype_hi_groups = 1
  let g:gruvbox_plugin_hi_groups = 1
  ]]

  local palette = require 'colors.palettes'

  local rainbow_colors = {
    palette.gruv.fg0,
    palette.gruv.blue,
    palette.gruv.purple,
    palette.gruv.yellow,
    palette.gruv.green,
    palette.gruv.orange,
    palette.gruv.dkPurple,
    palette.gruv.dkBlue,
    palette.gruv.dkYellow,
    palette.gruv.dkGreen,
    palette.gruv.dkOrange,
  }

  vim.api.nvim_set_hl(0, 'IndentBlanklineContextChar', { fg = palette.gruv.blue })

  if vim.g.gruvbox_transp_bg then
    vim.api.nvim_set_hl(0, 'FoldColumn', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'Folded', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'BufferTabpageFill', { bg = 'none' })
    vim.cmd[[hi BufferTabpageFill guifg=none guibg=none]]
  end

  -- local f = require 'colors.rainbow_setter'
  -- f(rainbow_colors)
end

-- local lualine_theme = require 'lualine.themes.tokyonight'
-- lualine_theme.normal.c.bg = colors.bg

return { setup = setup, status_theme = 'gruvbox' }

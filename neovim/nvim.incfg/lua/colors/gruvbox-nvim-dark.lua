local colors = require('tokyonight.colors').setup { style = 'night' }

local function setup()
  vim.opt.background = 'dark'
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

  require('gruvbox').setup {
    undercurl = true,
    underline = true,
    bold = true,
    italic = true,
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true, -- invert background for search, diffs, statuslines and errors
    contrast = '', -- can be "hard", "soft" or empty string
    overrides = {},
  }

  vim.cmd 'colorscheme gruvbox'
  -- require('colors.util').set_rainbow(rainbow_colors)

  if true then
    vim.api.nvim_set_hl(0, "Normal", {guibg = NONE, ctermbg = NONE})
    vim.api.nvim_set_hl(0, 'FoldColumn', { bg = NONE })
    vim.api.nvim_set_hl(0, 'SignColumn', { bg = NONE })
    vim.api.nvim_set_hl(0, 'Folded', { bg = NONE })
    vim.api.nvim_set_hl(0, 'BufferTabpageFill', { bg = NONE })
    -- vim.cmd[[hi BufferTabpageFill guifg=none guibg=none]]
  end
end

local lualine_theme = 'gruvbox'
-- lualine_theme.normal.c.bg = 'none'

return { setup = setup, status_theme = lualine_theme }

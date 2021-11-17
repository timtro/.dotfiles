local colors = require('tokyonight.colors').setup { style = 'night' }

local function setup()
  vim.opt.background = 'dark'
  vim.g.tokyonight_style = 'night'

  vim.g.tokyonight_transparent = false
  vim.g.tokyonight_italic_comments = false
  vim.g.tokyonight_italic_keywords = true
  vim.g.tokyonight_italic_functions = false
  vim.g.tokyonight_italic_variables = false
  vim.g.tokyonight_hide_inactive_statusline = false
  vim.g.tokyonight_sidebars = { 'packer' }
  vim.g.tokyonight_transparent_sidebar = true
  vim.g.tokyonight_dark_sidebar = false
  vim.g.tokyonight_dark_float = true
  vim.g.tokyonight_colors = {}
  vim.g.tokyonight_day_brightness = 0.3
  vim.g.tokyonight_lualine_bold = true

  local rainbow_colors = {
    colors.blue,
    colors.purple,
    colors.yellow,
    colors.blue1,
    colors.orange,
    colors.green,
    colors.fg,
  }

  vim.cmd 'colorscheme tokyonight'
  require('colors.util').set_rainbow(rainbow_colors)
end

local lualine_theme = require 'lualine.themes.tokyonight'
lualine_theme.normal.c.bg = colors.bg

return { setup = setup, status_theme = lualine_theme }

local colors = require('tokyonight.colors').setup {}

local function setup()
  vim.opt.background = 'dark'
  vim.g.tokyonight_style = 'storm'

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

  require('colors.util').set_rainbow {
    colors.fg,
    colors.purple,
    colors.blue,
    colors.yellow,
    colors.orange,
    colors.teal,
    colors.red,
  }

  vim.cmd 'colorscheme tokyonight'
end

return { setup = setup, status_theme = 'tokyonight' }

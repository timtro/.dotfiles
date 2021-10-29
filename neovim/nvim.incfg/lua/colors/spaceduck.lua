vim.opt.background = 'dark'

vim.cmd [[
  if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif
]]
vim.cmd 'colorscheme spaceduck'

local colors = {
  black = '#0f111b',
  white = '#ecf0c1',
  red = '#e33400',
  green = '#5ccc96',
  blue = '#00a3cc',
  purple = '#7a5ccc',
  yellow = '#f2ce00',
  gray = '#686f9a',
  darkgray = '#30365F',
  lightgray = '#c1c3cc',
}

local rainbow_colors = {
  colors.white,
  colors.purple,
  colors.blue,
  colors.yellow,
  colors.gray,
  colors.red,
};

(require 'colors.rainbow_setter')(rainbow_colors)

return { status_theme = 'spaceduck' }
